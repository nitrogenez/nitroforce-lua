# nitroforce

<h1 align=center>
    <b>nitroforce</b>
</h1>

## Description
This program randomly picks 4 digits from 0 to 9 and then sends combination to the phone through adb shell.

## Pre-requisites
+ USB-Debugging must be **ON**
+ Your PC fingerprint must be **AUTHORIZED**
+ You must have Lua interpreter **INSTALLED**

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