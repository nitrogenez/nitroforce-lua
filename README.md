<h1 align=center>
    <img src=icon.webp width=30% alt=Icon></img>

    nitroforce
</h1>

## Description
This program randomly picks 4 digits from 0 to 9 and then sends combination to the phone through adb shell.

## Pre-requisites
+ USB-Debugging must be **ON**
+ Your PC fingerprint must be **AUTHORIZED**
+ You must have Lua interpreter **INSTALLED**

## adb installation
+ **Arch-based distributions**
  - `sudo pacman -S android-tools`
+ **Debian-based distributions**
  - `sudo apt-get install android-tools-adb`
+ **MacOS**
  - **Homebrew**: `brew install android-platform-tools`
  - **Manually**
    + Delete old installation: `rm -rf ~/.android-sdk-macosx`
    + Go [here](https://developer.android.com/studio/releases/platform-tools.html) and click on `SDK Platform-Tools for Mac`
    + Navigate to Downloads dir: `cd ~/Downloads`
    + Unzip tools: `unzip platform-tools-latest*.zip`
    + Move contents anywhere, e.g:
      - `mkdir ~/.android-sdk-macosx`
      - `mv platform-tools-latest.../ ~/.android-sdk-macosx/platform-tools`
    + Add `platform-tools` to `$PATH`:
      - `echo "export PATH=$PATH:~/.android-sdk-macosx/platform-tools/" >> ~/.bash_profile`
    + Source bash profile: `source ~/.bash_profile`

## Instructions
### Linux / MacOS
+ **Clone repository**
  - `git clone --depth=1 https://github.com/nitrogenez/nitroforce`
+ **Connect** target device to your machine **via USB**
+ Redirect into `nitroforce` directory
  - `cd /path/to/nitroforce/src`
+ Allow script execution (*optional*)
  - `chmod +x nitroforce.lua`
+ Run script **as root** (1st or 2nd method)
  - `sudo lua nitroforce.lua`
  - `sudo ./nitroforce.lua`


You can easily modify code to remove privilege check, but it might break **adb**.