profile="$(pacmd list-cards | sed -E "s/^[[:space:]]+(input|output):/\1:/g" | grep ^[oi] | sed "s/: .*$//g" | dmenu -i -p "Audio card profile")"

echo changing to profile $profile
pacmd set-card-profile 0 "$profile"
