FROM fedora:latest

RUN dnf install -y rpm-build rpm-devel fedora-packager bash git

COPY . /grub-android-prober
WORKDIR /grub-android-prober

RUN ./rpm/setup.sh
RUN mkdir -p /root/rpmbuild/{SOURCES,SPECS,RPMS,SRPMS}
RUN cp 30_android-prober grub-android-prober VERSION systemd/* /root/rpmbuild/SOURCES/
RUN cp rpm/grub-android-prober.spec /root/rpmbuild/SPECS/
RUN rpmbuild -ba /root/rpmbuild/SPECS/grub-android-prober.spec
RUN mkdir -p /output && cp /root/rpmbuild/RPMS/noarch/*.rpm /output/
