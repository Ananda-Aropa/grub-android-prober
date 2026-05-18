FROM archlinux:latest

# Update packages
RUN yes | pacman -Syyu base-devel grub bash fakeroot git

COPY . /grub-android-prober
WORKDIR /grub-android-prober

# Remove expiration date of nobody
RUN chage -E -1 nobody
RUN chown -hR nobody:nobody /grub-android-prober

# Setup source files
RUN runuser -u nobody bash distro/arch/gen_pkgbuild.sh

# Build
WORKDIR /grub-android-prober/distro/arch
RUN runuser -u nobody makepkg

RUN mkdir -p /output 
RUN mv /grub-android-prober/distro/arch/*.pkg.tar* /output/
