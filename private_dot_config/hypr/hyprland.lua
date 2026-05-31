------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
})

hl.monitor({
	output = "DP-3",
	mode = "1920x1080@144",
	position = "1920x0",
	scale = 1,
})

hl.monitor({
	output = "DP-1",
	mode = "1920x1080@60",
	position = "3840x0",
	scale = 1,
})

--------------------------
---- WORKSPACES RULES ----
--------------------------

hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "1", monitor = "DP-3", default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("$HOME/.config/hypr/scripts/firefox-bitwarden-resize.sh")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("sleep 10 && vicinae server")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("wlsunset -l 44.837927 -L -0.579294")
	hl.exec_cmd("waybar & dex --autostart --environment hyprland")
	hl.exec_cmd("hyprlock")
	hl.exec_cmd("sleep 10 && vesktop")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "34")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("XCURSOR_THEME", "XCursor-Pro-Dark")
hl.env("HYPRCURSOR_THEME", "XCursor-Pro-Dark-Hyprcursor")
hl.env("HYPRCURSOR_SIZE", "34")

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us,us",
		kb_variant = "intl, ",
		kb_options = "grp:alt_space_toggle",

		follow_mouse = 1,
		focus_on_close = 1,
		sensitivity = -0.5,
		numlock_by_default = true,
		accel_profile = "flat",

		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			scroll_factor = 0.5,
			tap_to_click = true,
		},
	},
})

hl.config({
	cursor = {
		zoom_rigid = true,
		zoom_detached_camera = false,
	},
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 4,

		col = {
			active_border = "rgba(cc2e2eaa)",
			inactive_border = "rgba(595959aa)",
		},

		layout = "dwindle",
		allow_tearing = false,
	},
})

hl.config({
	decoration = {
		rounding = 0,

		blur = {
			enabled = true,
			size = 10,
			passes = 3,
			new_optimizations = true,
			ignore_opacity = true,
			noise = 0,
			brightness = 0.90,
		},

		shadow = {
			enabled = false,
		},
	},
})

--------------------
---- ANIMATIONS ----
--------------------

-- Bezier curves
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })

-- Spring Curves
hl.curve("spring_menu", { type = "spring", mass = 1, stiffness = 80, dampening = 14 })
hl.curve("spring_window", { type = "spring", mass = 1, stiffness = 30, dampening = 8 })
hl.curve("spring_workspace", { type = "spring", mass = 1.2, stiffness = 30, dampening = 10 })

-- Window animations
hl.animation({ leaf = "windows", enabled = true, speed = 1, spring = "spring_window" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, spring = "spring_menu", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, spring = "spring_menu", style = "slide" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.6, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, spring = "spring_workspace", style = "slide" })

-----------------
---- LAYOUTS ----
-----------------

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

------------------
---- GESTURES ----
------------------

hl.gesture({
	fingers = 4,
	direction = "down",
	action = function()
		hl.plugin.hyprexpo.expo("toggle")
	end,
})

hl.gesture({
	fingers = 4,
	direction = "up",
	action = function()
		hl.plugin.hyprexpo.expo("toggle")
	end,
})

hl.gesture({
	fingers = 4,
	direction = "horizontal",
	action = "workspace",
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

hl.config({
	binds = {
		workspace_back_and_forth = true,
		disable_keybind_grabbing = false,
		movefocus_cycles_fullscreen = true,
		scroll_event_delay = 0,
	},
})

-----------------
---- DEVICES ----
-----------------

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

hl.device({
	name = "apple-inc.-magic-trackpad",
	sensitivity = 0.5,
})

hl.device({
	name = "compx-2.4g-receiver-mouse",
	sensitivity = -1.0,
	accel_profile = "adaptive",
})

----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
	match = { class = "^(brave|Brave)-browser$" },
	border_size = 0,
})

hl.window_rule({
	match = { initial_title = "^(Mozilla Firefox)$" },
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(org.qbittorrent.qBittorrent)$" },
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(brave-nngceckbapebfimnlniiiahkandclblb-Default)$" },
	float = true,
})

hl.window_rule({
	match = { class = "^(org.gnome.NautilusPreviewer)$" },
	float = true,
})

hl.window_rule({
	match = { class = "^(org.gnome.Nautilus)$" },
	float = true,
	border_size = 0,
	center = true,
})

hl.window_rule({
	match = { class = "^(X|x)dg-desktop-portal-gtk$" },
	float = true,
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(simple-package-tracker)$" },
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(SAMURAI)$" },
	float = true,
})

hl.window_rule({
	match = { class = "^(SunChaser)$" },
	float = true,
	center = true,
	suppress_event = "fullscreen",
})

hl.window_rule({
	match = { initial_title = "^(Picture-in-Picture)$" },
	float = true,
	pin = true,
	no_initial_focus = true,
	size = { "(monitor_w*0.40)", "(monitor_h*0.40)" },
	move = { "monitor_w-(monitor_w*0.40)", "25" },
})

hl.window_rule({
	match = { class = "^(vivaldi-stable)$" },
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(vivaldi-stable)$", initial_title = "^(Bitwarden - Vivaldi)$" },
	float = true,
	center = true,
})

hl.window_rule({
	match = { class = "^ONLYOFFICE" },
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(clipse)$" },
	float = true,
})

hl.window_rule({
	match = { class = "^(flameshot)$" },
	no_anim = true,
	float = true,
	move = "0 0",
	pin = true,
	monitor = 1,
})

hl.window_rule({
	match = { class = "^(GTK Application)$" },
	border_size = 0,
})

hl.window_rule({
	match = { class = "(zoom)", initial_title = "(menu window)" },
	stay_focused = true,
})

hl.window_rule({
	match = { class = "(zoom)", title = "(zoom)" },
	move = "(cursor_x-(window_w*0.5)) (cursor_y-(window_h*0.5))",
})

hl.window_rule({
	match = { class = "(zoom)", title = "(cc_receiver)" },
	border_size = 0,
})

hl.window_rule({
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	match = { class = "^(zen)$" },
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(app.zen_browser.zen)$" },
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(zenity)$" },
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(org.gnome.Calculator)$" },
	float = true,
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(org.gnome.Loupe)$" },
	float = true,
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(vesktop|WebCord|discord|legcord)$" },
	monitor = "DP-2",
	border_size = 0,
})

hl.window_rule({
	match = { class = "^(steam_app_284160)$" },
	fullscreen = true,
})

hl.window_rule({
	match = { class = "^(steam_app_284160)$", initial_title = "^$" },
	opacity = 0.0,
	no_blur = true,
	fullscreen_state = 0,
})

hl.window_rule({
	match = { class = "^(steam)$" },
	tile = true,
})

hl.layer_rule({
	match = { namespace = "vicinae" },
	blur = true,
	ignore_alpha = 0,
	no_anim = false,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.close())
hl.bind("CTRL + SHIFT + E", hl.dsp.exec_cmd("$HOME/.config/rofi/powermenu/type-3/powermenu.sh"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | tesseract stdin stdout | wl-copy'))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("flameshot gui & sleep 0.2 && hyprctl dispatch 'hl.dsp.cursor.move({ x = 2880, y = 540 })'"))
hl.bind("CTRL + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("vicinae 'vicinae://launch/clipboard/history?toggle=true'"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + S", hl.dsp.window.pin())
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Same but with letter keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + M", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "d" }))

-- Move window with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Same but with letter keys
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces with mainMod + [q-p]
hl.bind(mainMod .. " + q", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + w", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + e", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + r", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + t", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + y", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + u", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + i", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + o", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + p", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [q-p]
hl.bind(mainMod .. " + SHIFT + q", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + w", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + e", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + r", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + t", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + y", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + u", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + i", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + o", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + p", hl.dsp.window.move({ workspace = 10 }))

-- Media keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Cursor zoom controls
local zoom_in = [[
hyprctl -q eval "hl.config({ cursor = { zoom_factor = $(
  hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.2'
) } })"
]]

local zoom_out = [[
hyprctl -q eval "hl.config({ cursor = { zoom_factor = $(
  hyprctl getoption cursor:zoom_factor -j | jq '(.float / 1.2) | if . < 1 then 1 else . end'
) } })"
]]

local zoom_reset = [[
hyprctl -q eval "hl.config({ cursor = { zoom_factor = 1 } })"
]]

hl.bind(mainMod .. " + mouse_up", hl.dsp.exec_cmd(zoom_in))
hl.bind(mainMod .. " + mouse_down", hl.dsp.exec_cmd(zoom_out))

hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd(zoom_in))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.exec_cmd(zoom_in))
hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd(zoom_out))

hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.exec_cmd(zoom_reset))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.exec_cmd(zoom_reset))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd(zoom_reset))

-- Resize submap
hl.bind("CTRL + SHIFT + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

	hl.bind("M", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

	hl.bind("Escape", hl.dsp.submap("reset"))
end)

-----------------
---- PLUGINS ----
-----------------

hl.config({
	plugin = {
		hyprexpo = {
			show_workspace_numbers = true,
		},
		dynamic_cursors = {
			enabled = true,
			mode = "stretch",
			threshold = 2,

			rotate = {
				length = 20,
				offset = 0.0,
			},

			tilt = {
				limit = 5000,
				activation = "negative_quadratic",
			},

			shake = {
				enabled = true,
				threshold = 5.0,
				base = 4.0,
				speed = 4.0,
				influence = 0.0,
				limit = 0.0,
				timeout = 2000,
				effects = false,
				ipc = false,
			},

			hyprcursor = {
				nearest = 1,
				enabled = true,
				resolution = -1,
				fallback = "clientside",
			},
		},
	},
})
