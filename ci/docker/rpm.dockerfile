FROM fedora:latest

RUN dnf install -y rpm-build rpm-devel fedora-packager bash git

COPY . /grub-android-prober/
WORKDIR /grub-android-prober

RUN mkdir -p /root/rpmbuild/{SOURCES,SPECS,RPMS,SRPMS} /output
RUN find src -type f -exec cp -t /root/rpmbuild/SOURCES/ {} +
RUN cp rpm/grub-android-prober.spec /root/rpmbuild/SPECS/
RUN rpmbuild -ba /root/rpmbuild/SPECS/grub-android-prober.spec
RUN find /root/rpmbuild/RPMS -iname '*.rpm' -exec cp -t /output {} +
