# find out how many pofiles there are - at the beginning there will be just 1 - Default
profiles_list=$(gconftool-2 --get "/apps/gnome-terminal/global/profile_list" | sed "s|\[||;s|\]||;")
echo "1 Profiles List: " ${profiles_list}
last_profile=$(echo "${profiles_list}" | sed "s/^.*,//" | sed 's/Profile//')
echo "Last Profile Name/Number: " ${last_profile}

# set the "ProfileX" X number to 0 if only default is there or whatever the last is plus 1
if [ ${last_profile} == "Default" ]; then
    next_profile_number=0;
echo "1 New Profile Number: " ${next_profile_number}
else
    next_profile_number=$(( ${last_profile} + 1 ));
echo "2 New Profile Number: " ${next_profile_number}
fi
echo "New Profile Number: " ${next_profile_number}

# construct profiles list with extra profile "number"
profiles_list=$(echo "[${profiles_list},Profile${next_profile_number}]")
echo "1 Profiles List: " ${profiles_list}

# get a dump of the default profile, change global name to the new profile name
profileName=MyNewProfile
gconftool-2 --dump "/apps/gnome-terminal/profiles/Default" > /tmp/${USER}_gnome-terminal_profiles_${profileName}.xml
sed -i "s|Default|Profile${next_profile_number}|g" /tmp/${USER}_gnome-terminal_profiles_${profileName}.xml

# load new profile
gconftool-2 --load /tmp/${USER}_gnome-terminal_profiles_${profileName}.xml

# tell gnome-terminal that is has another profile
gconftool-2 --set --type list --list-type string "/apps/gnome-terminal/global/profile_list" "${profiles_list}"

# set properties
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Profile${next_profile_number}/visible_name "${profileName}"
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Profile${next_profile_number}/exit_action "hold"
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Profile${next_profile_number}/font "Monospace 14"
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Profile${next_profile_number}/background_color "#000000000000"
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Profile${next_profile_number}/foreground_color "#0000FFFF0000"
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Profile${next_profile_number}/scrollbar_position "hidden"
gconftool-2 --set --type boolean /apps/gnome-terminal/profiles/Profile${next_profile_number}/use_system_font "false"
gconftool-2 --set --type boolean /apps/gnome-terminal/profiles/Profile${next_profile_number}/use_theme_colors "false"
gconftool-2 --set --type boolean /apps/gnome-terminal/profiles/Profile${next_profile_number}/login_shell "true"
gconftool-2 --set --type boolean /apps/gnome-terminal/profiles/Profile${next_profile_number}/scrollback_unlimited "true"

# create a terminal
gnome-terminal --geometry=80x24+0+0 --profile=${profileName} title "${profileName}" --zoom 0.8 -e "/bin/sh"
