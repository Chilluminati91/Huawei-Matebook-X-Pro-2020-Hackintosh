# **Huawei Matebook X Pro 2020 macOS Catalina / (Big Sur BETA)**

OpenCore 6.0.1 Config to run macOS Catalina / (Big Sur BETA) on the Matebook X Pro 2020.

This whole setup took me about 50 work hours to get where it is now, if you want to buy me a beer or donate a bit you can do it [via Paypal](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=dopfunk91%40gmail.com&currency_code=EUR&source=url)! Appreciate it!

| Device | Spec |
| --- | --- |
| CPU | Intel i5-10210U / Intel i7-10510U |
| iGPU | Intel UHD 620 |
| dGPU | Nvidia MX250 (Disabled) |
| WIFI / BT | Intel AC9560 |
| SSD | 512GB WDC PC SN730 |
| Audio | Realtek ALC256 (id=97) |

### Not working:

*   Thunderbolt 3 (not tested)
*   Second USB-C Port (Does work if plugged in while booting)
*   Bluetooth (4.0 devices not supported yet)
*   Touchscreen (disabled for now)

## BIOS Modding:

ATTENTION! THIS CAN DAMAGE YOUR LAPTOP BEYOND REPAIR! 

This is only suggested for people who know what they are doing. I am not going to document the whole process on how to get the variables, but [this guide](https://www.reddit.com/r/MatebookXPro/comments/iih4q9/undervolting_on_all_huawei_devices_even_matebook/) should give you a good idea. Use RU.efi to make the necessary changes (as stated in the linked guide).

<table><tbody><tr><td>Function</td><td>Variable Offset</td><td>Change to</td></tr><tr><td>CFG Lock</td><td>0x3E</td><td>0x0</td></tr><tr><td>Overclocking Lock</td><td>0xDA</td><td>0x0</td></tr></tbody></table>

## Installation:

1.  Open the config.plist and make the following Changes:
    *   PlatformInfo: new MLB, System Serial Number and UUID
    *   If you dont have CFG Lock disabled enable AppleCPUPmCfgLock and AppleXcpmCfgLock under Kernel -> Quirks
2.  Create a bootable Linux (Ubuntu) USB (Enough guides on the internet) and [format your SSD in 4k Sectors](https://github.com/Chilluminati91/Huawei-Matebook-X-Pro-2020-Hackintosh/blob/master/format-nvme-4k.md). This is recommended but not necessary.
3.  Create a macOS Install Stick (Catalina or Big Sur) with gibmacOS (Guide: https://dortania.github.io/OpenCore-Install-Guide/installer-guide/mac-install.html).
4.  After the stick is complete close terminal, mount the EFI and add the OpenCore EFI. Open up DiskUtility and eject the Install Partitions on the very bottom first, then eject the USB drive (Eject All)
5.  Boot your Matebook while holding F2 and change the following Bios settings:
    *   Secure Boot: Disabled
    *   TPM: Disabled
    *   Thunderbolt -> Security Level: No Security
    *   Virtualization Technology: Disabled
6.  Insert the Opencore Stick, Boot your Matebook while holding F12 and select the USB drive. Navigate to Install macOS and press enter. Go through the macOS Installer. This will take a while (do not turn off the Laptop if it seems like its frozen) and a couple of automatic reboots. You will get a blackscreen after reaching the Apple logo. Close the lid for a second and open it again. This is necessary every time you boot macOS.
7.  Go through the macOS Setup

## Post-Installation:

*   Install [Heliport](https://github.com/OpenIntelWireless/HeliPort) for IntelWifi
*   Disable Forcetouch in Settings -> Trackpad
*   Undervolt your Matebook with [Voltageshift](https://github.com/sicreative/VoltageShift)
*   Install [ALCPlugFix](https://github.com/profzei/Matebook-X-Pro-2018/tree/master/ALCPlugFix)
*   For the Intel i7 version create a [custom CPUFriend](https://github.com/stevezhengshiqi/one-key-cpufriend)

### Fixing Sleep (taken from Profzei):

Open up terminal and make the following changes:

```
sudo pmset -a hibernatemode 0
sudo rm -rf /private/var/vm/sleepimage
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0
sudo pmset -a powernap 0
sudo pmset -a proximitywake 0
```

### Fixing Internal Speakers (taken from gnodipac886):

By default macOS only uses 2 out of your 4 speakers which sound muffled and are missing a lot of the high frequencies. Enable surround sound to get a way better audio experience.

1.  Open Audio MIDI Setup from applications
2.  Click on the "+" symbol on the bottom left corner
3.  Click "Create Muti-Output Device"
4.  Check both of the Built-in Output options
5.  Select the newly created device in the menu bar
6.  Enjoy your music!

## Thanks to:

*   The [Dortania Team](https://dortania.github.io/OpenCore-Install-Guide/) for their incredible guide and documentation
*   [moh.96](https://www.tonymacx86.com/members/moh-96.1994677/) and [BlvckBytes](https://www.tonymacx86.com/members/blvckbytes.1808868/) for the battery hotpatch
*   Rehabman for a lot of great guides and general knowledge
*   [Laozhiang](https://github.com/laozhiang/MateBook_13_14_XPro-Hackintosh) for a general idea on how to handle this laptop
*   The [OpenCore Team](https://github.com/acidanthera/OpenCorePkg/releases) for this brilliant bootloader
*   [gnodipac886](https://github.com/gnodipac886/MatebookXPro-hackintosh) and [profzei](https://github.com/profzei/Matebook-X-Pro-2018) for their respective repo's for the 2018 model and ACPI files
