FROM alpine:edge

RUN apk add --no-cache abuild build-base bash sudo

RUN adduser -D builder && addgroup builder abuild
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY . /grub-android-prober
RUN chown -R builder:builder /grub-android-prober
RUN apk update

USER builder
RUN abuild-keygen -an

USER root
RUN cp /home/builder/.abuild/*.pub /etc/apk/keys/

USER builder
WORKDIR /grub-android-prober

RUN bash /grub-android-prober/gen_pkgbuild.sh
RUN abuild checksum
RUN abuild -F -r
RUN sudo mkdir -p /output && sudo find /home/builder /grub-android-prober -iname '*.apk' -exec cp -t /output {} +
