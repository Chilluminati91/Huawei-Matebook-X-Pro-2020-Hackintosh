# **Huawei Matebook X Pro 2020 macOS Big Sur BETA**

OpenCore Config to run macOS Big Sur BETA on the Matebook X Pro 2020.

| Device | Spec |
| --- | --- |
| CPU | Intel i5-10210U / Intel i7-10510U |
| iGPU | Intel UHD 620 |
| dGPU | Nvidia MX250 (Disabled) |
| WIFI / BT | Intel AC9560 (id=97) |
| SSD | 512GB WDC PC SN730 |
| Audio | Realtek ALC256 |

### Not working:

*   Thunderbolt 3 (not tested)
*   Brightness Keys

### BIOS Modding:

ATTENTION! THIS CAN DAMAGE YOUR LAPTOP BEYOND REPAIR! 

This is only suggested for people who know what they are doing. I am not going to document the whole process on how to get the variables, but [this guide](https://www.reddit.com/r/MatebookXPro/comments/iih4q9/undervolting_on_all_huawei_devices_even_matebook/) should give you a good idea. Use RU.efi to make the necessary changes (as stated in the linked guide).

<table><tbody><tr><td>Function</td><td>Variable Offset</td><td>Change to</td></tr><tr><td>CFG Lock</td><td>0x3E</td><td>0x0</td></tr><tr><td>Overclocking Lock</td><td>0xDA</td><td>0x0</td></tr></tbody></table>

### Installation:

1.  Open the config.plist and make the following Changes:
    *   PlatformInfo: new MLB, System Serial Number and UUID
    *   If you dont have CFG Lock disabled (Guide will follow) enable AppleCPUPmCfgLock and AppleXcpmCfgLock under Kernel -> Quirks
2.  Create a bootable Linux (Ubuntu) USB (Enough guides on the internet) and format your SSD in 4k Sectors. This is recommended but not necessary.
3.  Create a macOS Install Stick (Big Sur) with gibmacOS (Guide: https://dortania.github.io/OpenCore-Install-Guide/extras/big-sur/#installation).
4.  After the stick is complete close terminal, mount the EFI and add the OpenCore EFI. Open up DiskUtility and eject the Install Partitions on the very bottom first, then eject the USB drive (Eject All)
5.  Boot your Matebook while holding F2 and change the following Bios settings:
    *   Secure Boot: Disabled
    *   TPM: Disabled
    *   Thunderbolt -> Security Level: No Security
    *   Virtualization Technology: Disabled
6.  Insert the Opencore Stick, Boot your Matebook while holding F12 and select the USB drive. Navigate to Install macOS and press enter. Go through the macOS Installer. This will take a while (do not turn off the Laptop if it seems like its frozen) and a couple of automatic reboots. You will get a blackscreen after reaching the Apple logo. Close the lid for a second and open it again. This is necessary every time you boot macOS.
7.  Go through the macOS Setup and once you reach the desktop, go to settings -> Trackpad and disable ForceTouch.
