#!/usr/bin/env bash

notification_id=9998
duration=5
interval=0.5

# --- Dependencies ---
if ! command -v sensors &>/dev/null; then
    notify-send -r "$notification_id" "Temperature Monitor" "'sensors' is not installed."
    exit 1
fi

has_nvidia=0
if command -v nvidia-smi &>/dev/null; then
    has_nvidia=1
fi

# --- Readers ---
get_cpu_temp() {
    # Try AMD Tctl, then Intel Package id 0, then Dell ddv "CPU:"
    sensors 2>/dev/null | awk '
      /Tctl:/          { gsub(/\+|°C/,"",$2); printf "%d°C\n",$2+0; exit }
      /Package id 0:/  { gsub(/\+|°C/,"",$4); printf "%d°C\n",$4+0; exit }
      /^[[:space:]]*CPU:[[:space:]]*\+/ { gsub(/\+|°C/,"",$2); printf "%d°C\n",$2+0; exit }
    '
}

get_gpu_temp() {
    [ "$has_nvidia" -eq 1 ] || { echo ""; return; }
    nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null \
      | head -n1 | awk '{ printf "%d°C\n", $1+0 }'
}

# --- Notify loop ---
start=$SECONDS
while [ $SECONDS -lt $duration ]; do
    cpu="$(get_cpu_temp)"
    gpu="$(get_gpu_temp)"

    if [ -n "$gpu" ]; then
        body=" 
CPU: $cpu
GPU: $gpu"
    else
        body=" 
CPU: $cpu"
    fi

    notify-send -r "$notification_id" "Current temperature" "$body"
    sleep "$interval"
done

