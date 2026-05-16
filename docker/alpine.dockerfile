FROM alpine:edge

RUN apk add --no-cache abuild build-base bash sudo

RUN adduser -D builder && addgroup builder abuild
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY . /grub-android-prober
RUN chown -R builder:builder /grub-android-prober
RUN apk update

USER builder
WORKDIR /grub-android-prober

RUN bash /grub-android-prober/gen_pkgbuild.sh
RUN abuild-keygen -an
RUN abuild checksum
RUN abuild -F -r
RUN sudo mkdir -p /output && sudo cp /home/builder/packages/grub-android-prober/noarch/*.apk /output/
