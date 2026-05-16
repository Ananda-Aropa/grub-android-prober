# grub-android-prober

`grub-android-prober` is a tool designed to automatically detect Android-x86 and ARM64 Android based distributions (like Bliss OS, Phoenix OS, PrimeOS, LineageOS, and AOSP) on your system and generate the appropriate GRUB configuration entries. It supports various file systems and installation methods, including EDK II ARM64 systems using [AAROPA](https://github.com/orgs/Ananda-Aropa) (Ananda-Aropa) first-stage init or vendor-as-root feature, providing a seamless way to boot Android alongside your Linux distribution.

## Features

- **Automated Detection:** Scans partitions for Android installations.
- **Support for Multiple Distros:** Works with Bliss OS, Phoenix OS, PrimeOS, LineageOS, and standard Android-x86/ARM64.
- **AAROPA-exclusive features:** Designed to support EDK II ARM64 Android & Linux dual boot systems using [AAROPA](https://github.com/orgs/Ananda-Aropa) first-stage init ([bootable/aaropa](https://github.com/Ananda-Aropa/bootable_aaropa)) or vendor-as-root feature.
- **Cache Support:** Speeds up boot configuration generation by caching results.
- **Customizable:** Configurable search paths, excluded directories, and kernel parameters.
- **Systemd Integration:** Optional timer for periodic cache updates.

## Install

### Arch Linux

```sh
yay -S grub-android-prober
# or
paru -S grub-android-prober
# or
pamac install grub-android-prober
# or any aur helper you got
```

Alternatively, you can use the following method for distros that don't have official package

### Quick install

Make sure you have superuser permission (`sudo su` or `doas su`) and /usr/local/bin is in your `$PATH`

```sh
wget -O /etc/grub.d/30_android-prober https://github.com/shadichy/grub-android-x86/raw/master/30_android-prober
wget -O /usr/local/bin/grub-android-prober https://github.com/shadichy/grub-android-x86/raw/master/grub-android-prober
chmod +x /etc/grub.d/30_android-prober /usr/local/bin/grub-android-prober
```

Or with `curl`

```sh
curl -Lo /etc/grub.d/30_android-prober https://github.com/shadichy/grub-android-x86/raw/master/30_android-prober
curl -Lo /usr/local/bin/grub-android-prober https://github.com/shadichy/grub-android-x86/raw/master/grub-android-prober
chmod +x /etc/grub.d/30_android-prober /usr/local/bin/grub-android-prober
```

## Configuration

These are configurations of grub-android-prober .
Those can be set in either `/etc/defaults/grub` or `/etc/grub-android.conf`

Default values are in file `grub-android-prober`

### GRUB_ANDROID_SUPPORTED_FS

Specify which filesystems contains Android or the ones this program will try to search for Android on
> Note: by default, Android initramfs don't support btrfs and some other filesystems,
> but BlissOS does support btrfs

```sh
GRUB_ANDROID_SUPPORTED_FS="ext2 ext3 ext4 vfat exfat ntfs"
```

### GRUB_ANDROID_EXCLUDE_SEARCH

Specify which paths will be excluded during search
> Note: path must start with a slash, and be separated by ","  (comma) ending slashes are not needed

```sh
GRUB_ANDROID_EXCLUDE_SEARCH="/bin,/boot/efi,/dev,/lib,/lib64,/proc,/run,/sbin,/sys,/tmp"
```

### GRUB_ANDROID_INCLUDE_SEARCH

Specify which files/folders will be search for/detecting

```sh
GRUB_ANDROID_SEARCH="system system.img system.sfs system_a.img"
```

### GRUB_ANDROID_SEARCH_DEPTH

Specify max recursive directory search limit

```sh
GRUB_ANDROID_SEARCH_DEPTH=5
```

## Build

First clone the repository

```sh
git clone https://github.com/shadichy/grub-android-x86
cd ./grub-android-x86
```

### Arch Linux

```sh
makepkg -si
```

### Debian

```sh
dpkg-buildpackage
```
