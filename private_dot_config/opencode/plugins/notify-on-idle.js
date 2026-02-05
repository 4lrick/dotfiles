import fs from "node:fs/promises";
import os from "node:os";

const getParentPid = async (pid) => {
  try {
    const stat = await fs.readFile(`/proc/${pid}/stat`, "utf8");
    const afterName = stat.slice(stat.lastIndexOf(")") + 2);
    const fields = afterName.split(" ");
    const ppid = Number(fields[1]);
    return Number.isFinite(ppid) ? ppid : null;
  } catch {
    return null;
  }
};

const HOME_DIR = process.env.HOME ?? os.homedir();

const SOUND_PATHS = [
  `${HOME_DIR}/.config/opencode/sounds/complete.wav`,
  "/usr/share/sounds/freedesktop/stereo/complete.oga",
  "/usr/share/sounds/freedesktop/stereo/bell.wav",
];

const SOUND_COMMANDS = ["paplay", "aplay", "mpv", "ffplay"];

const getSoundPath = async () => {
  for (const path of SOUND_PATHS) {
    try {
      await fs.access(path);
      return path;
    } catch {
      continue;
    }
  }
  return null;
};

const playSound = async ($) => {
  const soundPath = await getSoundPath();
  if (!soundPath) {
    return;
  }

  for (const command of SOUND_COMMANDS) {
    const result = await $`${command} ${soundPath}`.quiet().nothrow();
    if (result.exitCode === 0) {
      return;
    }
  }
};

const isPidInAncestry = async (targetPid, startPid) => {
  let currentPid = startPid;
  while (Number.isFinite(currentPid) && currentPid > 1) {
    if (currentPid === targetPid) {
      return true;
    }
    const parentPid = await getParentPid(currentPid);
    if (!parentPid || parentPid === currentPid) {
      break;
    }
    currentPid = parentPid;
  }

  return false;
};

const getActiveTerminalInfo = async ($, pid) => {
  const activeWindowOutput = await $`hyprctl activewindow -j`.quiet().nothrow();
  if (activeWindowOutput.exitCode !== 0) {
    return null;
  }

  try {
    const activeWindow = JSON.parse(activeWindowOutput.text());
    const activePid = Number(activeWindow?.pid);
    if (!Number.isFinite(activePid)) {
      return null;
    }

    const isTerminal = await isPidInAncestry(activePid, pid);
    if (!isTerminal) {
      return null;
    }

    return {
      pid: activePid,
      address: typeof activeWindow?.address === "string" ? activeWindow.address : null,
      title: typeof activeWindow?.title === "string" ? activeWindow.title : null,
    };
  } catch {
    return null;
  }
};

const findClientCandidates = async ($, pid) => {
  const clientsOutput = await $`hyprctl clients -j`.quiet().nothrow();
  if (clientsOutput.exitCode !== 0) {
    return [];
  }

  try {
    const clients = JSON.parse(clientsOutput.text());
    if (!Array.isArray(clients)) {
      return [];
    }

    const candidates = [];
    for (const client of clients) {
      const clientPid = Number(client?.pid);
      if (!Number.isFinite(clientPid)) {
        continue;
      }

      const matches = await isPidInAncestry(clientPid, pid);
      if (!matches) {
        continue;
      }

      candidates.push({
        pid: clientPid,
        address: typeof client?.address === "string" ? client.address : null,
        title: typeof client?.title === "string" ? client.title : null,
      });
    }

    return candidates;
  } catch {
    return [];
  }
};

const pickTerminalAddress = (candidates, terminalTitle) => {
  if (candidates.length === 0) {
    return null;
  }

  if (terminalTitle) {
    const exactMatch = candidates.find((candidate) => candidate.title === terminalTitle);
    if (exactMatch?.address) {
      return exactMatch.address;
    }
  }

  if (candidates.length === 1) {
    return candidates[0].address ?? null;
  }

  return null;
};

const isActiveWindowFocused = async ($, pid, terminalAddress, terminalTitle) => {
  const activeWindowOutput = await $`hyprctl activewindow -j`.quiet().nothrow();
  if (activeWindowOutput.exitCode !== 0) {
    return false;
  }

  try {
    const activeWindow = JSON.parse(activeWindowOutput.text());
    const activeAddress =
      typeof activeWindow?.address === "string" ? activeWindow.address : null;
    const activeTitle =
      typeof activeWindow?.title === "string" ? activeWindow.title : null;
    const activePid = Number(activeWindow?.pid);

    if (terminalAddress && activeAddress) {
      return activeAddress === terminalAddress;
    }

    if (terminalTitle && activeTitle) {
      return activeTitle === terminalTitle;
    }

    if (Number.isFinite(activePid)) {
      return await isPidInAncestry(activePid, pid);
    }
  } catch {
    return false;
  }

  return false;
};

const notifyWithFocus = async ($, title, body, focusTarget) => {
  const actionResult = await $`notify-send --action=default=Focus --wait ${title} ${body}`
    .quiet()
    .nothrow();
  const action = actionResult.text().trim();

  if (actionResult.exitCode === 0 && action === "default" && focusTarget) {
    if (focusTarget.address) {
      await $`hyprctl dispatch focuswindow address:${focusTarget.address}`
        .quiet()
        .nothrow();
      return;
    }
    if (focusTarget.pid) {
      await $`hyprctl dispatch focuswindow pid:${focusTarget.pid}`
        .quiet()
        .nothrow();
      return;
    }
    return;
  }

  if (actionResult.exitCode !== 0) {
    await $`notify-send ${title} ${body}`.quiet().nothrow();
  }
};

const formatSessionLabel = (session) => {
  if (!session) {
    return null;
  }

  const title = session.title?.trim();
  if (title) {
    return title;
  }

  const directory = session.directory?.trim();
  if (!directory) {
    return null;
  }

  const parts = directory.split("/").filter(Boolean);
  return parts.length ? parts[parts.length - 1] : directory;
};

const getSessionInfo = async (client, sessionID) => {
  if (!sessionID) {
    return { label: null, isSubagent: false };
  }

  const sessionResponse = await client.session.get({
    path: { id: sessionID },
  });
  const session = sessionResponse?.data;

  return {
    label: formatSessionLabel(session),
    isSubagent: Boolean(session?.parentID),
  };
};

export const NotifyOnIdlePlugin = async ({ $, client }) => {
  const terminalInfo = await getActiveTerminalInfo($, process.pid);
  let terminalAddress = terminalInfo?.address ?? null;
  const terminalTitle = terminalInfo?.title ?? null;

  return {
    event: async ({ event }) => {
      if (
        event.type !== "session.idle" &&
        event.type !== "session.error" &&
        event.type !== "permission.updated" &&
        event.type !== "question.asked"
      ) {
        return;
      }

      if (!terminalAddress) {
        const candidates = await findClientCandidates($, process.pid);
        terminalAddress = pickTerminalAddress(candidates, terminalTitle);
      }

      const focused = await isActiveWindowFocused(
        $,
        process.pid,
        terminalAddress,
        terminalTitle
      );
      if (focused) {
        return;
      }

      const { label: sessionLabel, isSubagent } = await getSessionInfo(
        client,
        event.properties?.sessionID
      );

      const title = "OpenCode";
      let body = "Session finished";

      if (event.type === "question.asked") {
        const question = event.properties?.questions?.[0];
        const questionText = question?.header?.trim() || question?.question?.trim();
        if (sessionLabel && questionText) {
          body = `Question (${sessionLabel}): ${questionText}`;
        } else if (questionText) {
          body = `Question: ${questionText}`;
        } else if (sessionLabel) {
          body = `Question (${sessionLabel})`;
        } else {
          body = "Question asked";
        }
      } else if (event.type === "permission.updated") {
        const permissionTitle = event.properties?.title?.trim();
        if (permissionTitle && sessionLabel) {
          body = `Permission (${sessionLabel}): ${permissionTitle}`;
        } else if (permissionTitle) {
          body = `Permission: ${permissionTitle}`;
        } else if (sessionLabel) {
          body = `Permission (${sessionLabel})`;
        } else {
          body = "Permission needed";
        }
      } else if (event.type === "session.error") {
        const errorMessage = event.properties?.error?.message?.trim();
        if (errorMessage && sessionLabel) {
          body = `Error (${sessionLabel}): ${errorMessage}`;
        } else if (errorMessage) {
          body = `Error: ${errorMessage}`;
        } else if (sessionLabel) {
          body = `Error (${sessionLabel})`;
        } else {
          body = "Session error";
        }
      } else if (event.type === "session.idle") {
        if (isSubagent && sessionLabel) {
          body = `Subagent finished: ${sessionLabel}`;
        } else if (isSubagent) {
          body = "Subagent finished";
        } else if (sessionLabel) {
          body = `Finished: ${sessionLabel}`;
        }
      }
      const candidates = await findClientCandidates($, process.pid);
      const focusTarget = {
        address: terminalAddress ?? pickTerminalAddress(candidates, terminalTitle),
        pid: candidates.length ? candidates[0].pid : null,
      };

      void playSound($);
      void notifyWithFocus($, title, body, focusTarget);
    },
  };
};
