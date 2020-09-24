# Formatting your nvme to 4k sectors

### Warning: This will wipe your SSD and remove all the data!

*   Create a bootable Linux USB, I'd suggest [Ubuntu](https://ubuntu.com/download) and Balena Etcher on macOS
*   Boot into Ubuntu and connect to your WIFI
*   Open up your settings and enable Universe Repo
*   Open up the commandline and insert the following commands one after the other:

```
sudo apt install smartmontools
sudo apt install nvme-cli
sudo smartctl -a /dev/nvme0
```

After entering the last command you should find the following output in the commandline tool indicating that it is possible to format to 4k sectors:

```
    Supported LBA Sizes (NSID 0x1)
    Id Fmt  Data  Metadt  Rel_Perf
     0 +     512       0         2
     1 -    4096       0         1
```

*   Use the following command to format your SSD:

```
sudo nvme format -l 1 /dev/nvme0
```
