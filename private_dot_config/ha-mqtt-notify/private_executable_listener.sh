#!/bin/sh

mosquitto_sub \
	-h "$MQTT_HOST" \
	-p "$MQTT_PORT" \
	-u "$MQTT_USER" \
	-P "$MQTT_PASSWORD" \
	-t "$MQTT_TOPIC" |
	while read -r payload; do
		title=$(printf '%s' "$payload" | jq -r '.title // "Home Assistant"')
		message=$(printf '%s' "$payload" | jq -r '.message // empty')
		image_url=$(printf '%s' "$payload" | jq -r '.image_url // empty')
		url=$(printf '%s' "$payload" | jq -r '.url // empty')
		icon=""

		if [ -n "$image_url" ]; then
			icon="/tmp/ha-notify-image.jpg"
			curl -fsSL \
				-H "Authorization: Bearer $HA_TOKEN" \
				"$image_url" \
				-o "$icon" || icon=""
		else
			icon="/tmp/ha-notify-icon.png"
			curl -fsSL \
				"http://$MQTT_HOST:8123/static/icons/favicon-192x192.png" \
				-o "$icon" || icon=""
		fi

		action=$(notify-send -a "Home Assistant" -i "$icon" -A "open=Open" "$title" "$message")

		if [ "$action" = "open" ] && [ -n "$url" ]; then
			xdg-open "$url" >/dev/null 2>&1
		fi

		[ -n "$icon" ] && rm -f "$icon"
	done
