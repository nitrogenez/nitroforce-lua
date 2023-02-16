<h2 align=center>
  <img align=center src=icon.webp width=30% alt=Icon></img>
</h2>

<h1 align=center><b>NITROFORCE</b></h1>


## **DESCRIPTION**
**NITROFORCE** picks random number from 0..9 4 times and passes generated 4-digit combination into Android smartphone through **adb**.

> **NOTICE**  
> This software was developed for educational purposes ONLY.  
Author do not take any responsibility for his software's users or any unfair/malicious usage.


## **PRE-REQUISITES**
  + Install [Lua](http://www.lua.org/) [interpreter](http://www.lua.org/download.html)
  + Enable USB-Debugging on your Android phone


## **ADB INSTALLATION**
  + **Arch-based distributions**
    - `sudo pacman -S android-tools`
  + **Debian-based distributions**
    - `sudo apt-get install android-tools-adb`
  + **MacOS**: See [MACOSX_INSTALLATION](MACOSX_INSTALLATION.md)


## **QUICK GUIDE**
+ **Linux/MacOS X**
  - Clone or download repository: `git clone https://github.com/nitrogenez/nitroforce`
  - Connect target device to your machine via USB
  - Goto `nitroforce` directory: `cd /path/to/nitroforce`
  - Mark script as an executable (*optional*): `chmod +x src/nitroforce.lua`
  - Run script **as root**:
    + `sudo src/nitroforce.lua` or
    + `sudo lua src/nitroforce.lua`


## **EXAMPLE**
```bash
git clone https://github.com/nitrogenez/nitroforce
cd ~/nitroforce
chmod +x src/nitroforce.lua
sudo src/nitroforce.lua
```

## **LICENSE**
**This software is licensed under GNU Affero General Public License v3-or-later.**
See [LICENSE.md](LICENSE.md) for further details.


<h2 align=center>ILLGIVEYOUNITROGENESIS</h2>