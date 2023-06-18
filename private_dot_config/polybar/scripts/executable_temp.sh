#!/usr/bin/env bash

notification_id=$$  # Utilise le PID comme ID de notification unique
duration=5  # Durée de la boucle en secondes
end_time=$((SECONDS + duration))  # Calcul de l'heure de fin

while [ $SECONDS -lt $end_time ]; do
    temperature=$(sensors)
    notify-send -r "$notification_id" "Température actuelle" "\n$temperature"
    sleep 0.5  # Définissez ici l'intervalle de mise à jour en secondes
done

