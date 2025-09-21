# ADB App Removal Script

This repository provides tools to safely reduce **bloatware** (unnecessary pre-installed apps) on Samsung Android devices using **ADB** without **root**. By default, some applications require to uninstall update and disable the application. By uninstalling the package via adb command, it will allow to completely remove the application.

The focus is on removing apps from Samsung, Google, Microsoft, Facebook, and other third-party vendors that are safe to uninstall. Most of these apps can be reinstalled at any time from the **Samsung Galaxy Store** or **Google Play Store**, giving you more control over your device.

- Automated **Bash script**.    
- Copy-and-paste **One-Liner command** included.    

> 📌 Notes:
>
> ⚠️ Before running the commands/script, please check the packages in the bash script to get more information about the application. Remove the package line related to the application you want to keep.
>
> ✅ Test successful with bash script on: S24 Ultra
>
> You can also install an application such as `App Inspector` from Google Play Store to get a list of the applications and their package name.

---

## Why use ADB to remove bloatwares?

- **Removes apps from your launcher and background**:  
  The app disappears from your app drawer and won’t run background services, saving CPU cycles and battery.

- **Stops auto-start and notifications**:  
  Disabled apps can’t start themselves, push notifications, or interfere with your workflow.

- **Reduces clutter**:  
  Your phone feels cleaner and less overwhelming when unnecessary pre-installed apps are hidden.

- **Frees up user data and cache**:  
  While the APK remains, uninstalling clears all associated user data, caches, and updates, freeing meaningful storage space.

- **No root required**:  
  Unlike fully deleting system apps, this method doesn’t void your warranty or trip Samsung Knox.

- **Reversible**:  
  You can easily restore apps.

---

## Limitations

- **Reinstallation behavior**:  
  If you reinstall an app from the **Samsung Galaxy Store** or **Google Play Store**, it will come back as a normal user app.  
  However, if the app was originally a **system app** that you removed with `adb uninstall --user 0`, you will still need to use **ADB** again to uninstall it.

- **Factory reset**:  
  Uninstalling with `--user 0` only removes the app for the current user. The app’s package remains in the system partition.  
  This means that after a **factory reset**, all pre-installed (system) apps will be restored.

- **No storage savings**:  
  Because the APKs stay on the system partition, uninstalling in this way frees up **data and cache space**, but does **not** reduce total system storage usage.

- **Updates may reinstall apps**:  
  Major system updates (e.g., One UI or Android version upgrades) can also re-enable or reinstall pre-loaded apps, requiring you to repeat the process.

> 📌 If you want to truly delete system apps, you would need **root access** to your device which is not recommended because it will void your warranty.

---

## Requirements

- Android Phone with the USB cable
- Computer with ADB Packages/Software

---

## Instructions

### Install Packages/Software

#### Linux (Ubuntu)

1. Open your terminal and run: `sudo apt update && sudo apt install android-tools-adb android-tools-fastboot -y`

#### Windows

1. Go to the following URL to download and install SDK Platform Tools: https://developer.android.com/tools/releases/platform-tools
2. If asked during installation, add it to the PATH.

> 📌 Note: You can always use WSL if you would like to use the bash script.

### Packages/Software Validation

1. Validate that your packages/software are working as expected by running the following command: `adb devices`

### Prepare your Android device

1. Open your phone
2. Open your `Settings`
3. Tap on `About phone`
4. Tap on `Software information`
5. Tap multiple times on `Build number`
6. Go back to `Settings`
7. Tap on `Developper options`
8. Enable `USB debugging`
9. Optional: Enabe `Stay awake` which allow the phone to stay open and prevent from locking it
10. Connect your phon to your computer
11. Allow the communications (pop-ups on your phone)

### Remove the built-in apps (bloatwares)

**Recommended**: Please check the bash script to get more details about the packages and remove the lines related to the package you want to keep.

#### Bash Script

1. Download the bash script
2. Open the directory of the downloaded bash script
3. Open the terminal in the directory
4. Change the permissions: `chmod 700 adb_remove_builtin_apps.sh`
5. Run the script: `./adb_remove_builtin_apps.sh`


#### One-Liner command

1. Open a terminal
2. Copy & paste the following in your terminal:

```bash
adb shell pm uninstall --user 0 com.google.android.googlequicksearchbox &&
adb shell pm uninstall --user 0 com.android.hotwordenrollment.okgoogle &&
adb shell pm uninstall --user 0 com.android.hotwordenrollment.xgoogle &&
adb shell pm uninstall --user 0 com.google.android.gm &&
adb shell pm uninstall --user 0 com.google.android.apps.tachyon &&
adb shell pm uninstall --user 0 com.google.android.apps.youtube.music &&
adb shell pm uninstall --user 0 com.google.android.apps.youtube &&
adb shell pm uninstall --user 0 com.google.android.youtube &&
adb shell pm uninstall --user 0 com.google.android.apps.photos &&
adb shell pm uninstall --user 0 com.google.android.apps.docs &&
adb shell pm uninstall --user 0 com.google.android.apps.maps &&
adb shell pm uninstall --user 0 com.google.android.apps.videos &&
adb shell pm uninstall --user 0 com.google.android.apps.bard &&
adb shell pm uninstall --user 0 com.android.chrome &&
adb shell pm uninstall --user 0 com.sec.android.app.chromecustomizations &&
adb shell pm uninstall --user 0 com.google.android.health.connect.backuprestore &&
adb shell pm uninstall --user 0 com.google.android.healthconnect.controller &&
adb shell pm uninstall --user 0 com.spotify.music &&
adb shell pm uninstall --user 0 com.linkedin.android &&
adb shell pm uninstall --user 0 com.facebook.katana &&
adb shell pm uninstall --user 0 com.facebook.appmanager &&
adb shell pm uninstall --user 0 com.facebook.services &&
adb shell pm uninstall --user 0 com.facebook.system &&
adb shell pm uninstall --user 0 com.sec.android.mimage.avatarstickers &&
adb shell pm uninstall --user 0 com.microsoft.office.outlook &&
adb shell pm uninstall --user 0 com.microsoft.office.officehubrow &&
adb shell pm uninstall --user 0 com.microsoft.skydrive &&
adb shell pm uninstall --user 0 com.sec.android.app.sbrowser &&
adb shell pm uninstall --user 0 com.sec.android.app.shealth &&
adb shell pm uninstall --user 0 com.samsung.android.app.watchmanager &&
adb shell pm uninstall --user 0 com.samsung.android.spay &&
adb shell pm uninstall --user 0 com.samsung.sree &&
adb shell pm uninstall --user 0 com.samsung.android.smartswitchassistant &&
adb shell pm uninstall --user 0 com.sec.android.easyMove &&
adb shell pm uninstall --user 0 com.samsung.android.oneconnect &&
adb shell pm uninstall --user 0 com.samsung.android.bixby.agent &&
adb shell pm uninstall --user 0 com.samsung.android.bixby.wakeup &&
adb shell pm uninstall --user 0 com.samsung.android.bixby.ondevice.enus &&
adb shell pm uninstall --user 0 com.samsung.android.bixbyvision.framework &&
adb shell pm uninstall --user 0 com.samsung.android.app.find &&
adb shell pm uninstall --user 0 com.samsung.android.messaging &&
adb shell pm uninstall --user 0 com.samsung.android.tvplus &&
adb shell pm uninstall --user 0 com.samsung.android.stickercenter &&
adb shell pm uninstall --user 0 com.samsung.android.app.camera.sticker.facearavatar.preload &&
adb shell pm uninstall --user 0 com.samsung.android.aremoji &&
adb shell pm uninstall --user 0 com.samsung.android.aremojieditor &&
adb shell pm uninstall --user 0 com.samsung.android.app.tips &&
adb shell pm uninstall --user 0 com.samsung.android.app.parentalcare &&
adb shell pm uninstall --user 0 com.samsung.android.kidsinstaller &&
adb shell pm uninstall --user 0 com.sec.android.app.kidshome &&
adb shell pm uninstall --user 0 com.samsung.android.app.reminder &&
adb shell pm uninstall --user 0 com.samsung.android.app.spage
```

---

## Important notes

- It is recommended to disable `USB debugging` and `Stay awake` when you are done.
- ⚠️ You can delete more packages **at your own risk** ⚠️
  - Deleting important packages can break features and cause crash-loop.
  - Easiest fix:
    1. Reinstall the package via adb command (see next section).
    2. If you cannot use the adb command to reinstall the packages, boot your device in `Recovery Mode` and perform a `Factory reset`.
- Performing a factory reset will reset your phone to the initial state where some built-in apps cannot be completely uninstalled.
- You can reinstall packages you deleted if needed (see next section).

### Few useful ADB commands

- Check if your device is connected and authorized:  
  `adb devices`

- List all installed packages:  
  `adb shell pm list packages`

- Search for a specific package (example: "messaging"):  
  - Linux/macOS: `adb shell pm list packages | grep messaging`  
  - Windows (PowerShell): `adb shell pm list packages | Select-String "messaging"`
  - Windows (CMD): `adb shell pm list packages | findstr messaging`

- Remove a package:  
  `adb shell pm uninstall --user 0 <package name>`

- Reinstall a package that was removed:  
  `adb shell pm install-existing --user 0 <package name>`

- Install an APK manually:  
  `adb install <file.apk>`
