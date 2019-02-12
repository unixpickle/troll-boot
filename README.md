# troll-boot

An operating system that is just a trollface. Install this on a machine to surprise the next person to boot it.

# Setup

On Ubuntu:

```
sudo apt install grub-pc-bin xorriso nasm
```

Then run `make` to compile an ISO with the operating system.

# Installing on Mac

On a Mac, it's a huge pain to get this thing working. In the end, my solution is to use a Linux Live CD to install GRUB on the machine, and then replace the grub configuration file with a trollface.

Boot into an Ubuntu Live CD. Use `fdisk` to create a partition table and put one HFS+ partition. Use `mkfs.hfs` (installed via `apt install hfsprogs`). Then use the `grub-install` command to setup GRUB on the disk, and use [hfs-bless](https://github.com/detly/mactel-boot) to bless the `boot.efi` file. Finally, replace the `grub.cfg` file with the one stored in this repository.

You may encounter errors with `grub-install`. Sometimes, it's necessary to copy the contents of `/` to the Mac volume, and then to chroot into the Mac volume. Don't ask me why.
