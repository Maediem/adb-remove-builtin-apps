#!/usr/bin/env bash

# Package requirements: android-tools-adb android-tools-fastboot

# Script to uninstall selected apps via ADB for user 0

# Comments include company and app name for reference

# Example to search packages: adb shell pm list packages  | sed 's/^package://' | grep -P "samsung|google" | sort

#############
# VARIABLES #
#############

# Color codes for terminal output, making it easier to read.
readonly RED=$(tput setaf 1; tput bold)
readonly GREEN=$(tput setaf 2; tput bold)
readonly YELLOW=$(tput setaf 3; tput bold)
readonly BLUE=$(tput setaf 4; tput bold)
readonly RESET_COLOR=$(tput sgr0)

# List of packages to remove
readonly PACKAGES=(
# Google apps
com.google.android.googlequicksearchbox   # Google - Google Search Box
com.android.hotwordenrollment.okgoogle    # Google - OK Google / Voice Match enrollment
com.android.hotwordenrollment.xgoogle     # Google - Hey Google voice activation
com.google.android.gm                     # Google - Gmail
com.google.android.apps.tachyon           # Google - Duo (video calls)
com.google.android.apps.youtube.music     # Google - YouTube Music
com.google.android.apps.youtube           # Google - YouTube
com.google.android.youtube                # Google - YouTube (older package)
com.google.android.apps.photos            # Google - Google Photos
com.google.android.apps.docs              # Google - Google Docs
com.google.android.apps.maps              # Google - Google Maps
com.google.android.apps.videos            # Google - Google TV / Play Movies
com.google.android.apps.bard              # Google - Bard (Gemini AI)
com.android.chrome                        # Google - Chrome Browser
com.sec.android.app.chromecustomizations  # Google - Samsung Chrome customizations
com.google.android.health.connect.backuprestore               # Google - Google Health (Google Fit
com.google.android.healthconnect.controller                   # Google - Google Health (Google Fit

# Third-party apps
com.spotify.music                           # Spotify - Music
com.linkedin.android                        # LinkedIn - Social
com.facebook.katana                         # Facebook - App
com.facebook.appmanager                     # Facebook - Updates/Support
com.facebook.services                       # Facebook - Background services
com.facebook.system                         # Facebook - System level integration
com.sec.android.mimage.avatarstickers       # Avatar Stickers

# Microsoft apps
com.microsoft.office.outlook                # Microsoft - Outlook
com.microsoft.office.officehubrow           # Microsoft - Office Hub
com.microsoft.skydrive                      # Microsoft - OneDrive

# Samsung / system apps
com.sec.android.app.sbrowser                # Samsung - Internet Browser
com.sec.android.app.shealth                 # Samsung - Samsung Health
com.samsung.android.app.watchmanager        # Samsung - Galaxy Wearable
com.samsung.android.app.watchmanagerstub    # Samsung - Galaxy Wearable auto prompt to install
com.samsung.android.spay                    # Samsung - Samsung Pay
com.samsung.sree                            # Samsung - Global Goals
com.samsung.android.smartswitchassistant    # Samsung - Smart Switch (initial setup)
com.sec.android.easyMover                   # Samsung - Smart Switch
com.sec.android.easyMover.agent             # Samsung - Smart Switch Agent
com.samsung.android.oneconnect              # Samsung - SmartThings
com.samsung.android.bixby.agent             # Samsung - Bixby Agent
com.samsung.android.bixby.wakeup            # Samsung - Bixby Wakeup
com.samsung.android.bixby.ondevice.enus     # Samsung - Bixby on-device English US
com.samsung.android.visionintelligence      # Samsung - Bixby Vision
com.samsung.android.bixbyvision.framework   # Samsung - Bixby Vision Framework
com.samsung.android.app.find                # Samsung - Find My Mobile
com.samsung.android.messaging               # Samsung - Messages
com.samsung.android.tvplus                  # Samsung - TV Plus
com.samsung.android.stickercenter           # Samsung - Avatar Sticker
com.samsung.android.app.camera.sticker.facearavatar.preload # Samsung - Avatar Face
com.samsung.android.aremoji                 # Samsung - Avatar Emoji
com.samsung.android.aremojieditor           # Samsung - Avatar Editor
com.samsung.android.app.tips                # Samsung - Tips
com.samsung.android.app.parentalcare        # Samsung - Parental Control
com.samsung.android.kidsinstaller           # Samsung - Kids Installer
com.sec.android.app.kidshome                # Samsung - Kids Home
com.samsung.android.app.reminder            # Samsung - Reminder
com.samsung.android.app.spage               # Samsung - Free/Daily feed (news, content suggestions)
)



###############
# MAIN SCRIPT #
###############



# Check if adb is installed
if ! command -v adb >/dev/null 2>&1; then
    echo -e "adb command ${RED}not found${RESET_COLOR}. Please install adb."
    exit 1
fi

# Get list of connected devices (excluding header line)
device_count=$(adb devices | sed '1d' | grep -v '^$' | wc -l)

if [[ $device_count -eq 0 ]]; then
    echo "No devices connected for adb."
    exit 1
fi

# Check if any device is unauthorized
if adb devices | sed '1d' | grep -q "unauthorized"; then
    echo -e "Device is connected but not authorized for adb. Please ${YELLOW}authorize${RESET_COLOR} it on your device."
    exit 1
fi

echo -e "ADB is ready. ${BLUE}${device_count}${RESET_COLOR} device(s) connected."

echo -e "${GREEN}Starting${RESET_COLOR} app removal for ${BLUE}user 0${RESET_COLOR}..."

for pkg in "${PACKAGES[@]}"; do
    # Check if package is installed
    if adb shell pm list packages | grep -q "^package:$pkg$"; then
        if [[ "$pkg" == *messaging* ]]; then
            if [ "$(adb shell pm list packages | grep -c "messaging")" -gt 1 ]; then
                echo "There is more than 1 messaging app. Proceeding."
            else
                echo -e "Cannot delete ${YELLOW}${pkg}${RESET_CLOR} since there is no other messaging app."
                continue  # go to the next pkg in the loop
            fi
        fi
        
        echo -e "Removing ${YELLOW}${pkg}${RESET_COLOR}..."
        adb shell pm uninstall --user 0 "$pkg"
    else
        echo -e "Package ${YELLOW}${pkg}${RESET_COLOR} not installed, ${BLUE}skipping${RESET_COLOR}."
    fi
done

echo -e "App removal ${GREEN}completed${RESET_COLOR}."

