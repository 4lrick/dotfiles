#!/usr/bin/env bash

notification_id=9998
duration=5
interval=0.5

if ! command -v sensors &>/dev/null; then
    notify-send -r "$notification_id" "Temperature Monitor" "'sensors' is not installed."
    exit 1
fi

if ! command -v nvidia-smi &>/dev/null; then
    notify-send -r "$notification_id" "Temperature Monitor" "'nvidia-smi' is not installed."
    exit 1
fi

get_cpu_temp() {
    sensors 2>/dev/null | awk '/Tctl:/ { gsub(/\+|°C/, "", $2); printf "%d°C\n", $2; exit }'
}

get_gpu_temp() {
    nvidia-smi --query-gpu=temperature.gpu --format=noheader 2>/dev/null | awk '{printf "%d°C\n", $1}'
}

while [ $SECONDS -lt $duration ]; do
    cpu="$(get_cpu_temp)"
    gpu="$(get_gpu_temp)"

    notify-send -r "$notification_id" "Current temperature" " \nCPU: $cpu\nGPU: $gpu"
    sleep "$interval"
done
