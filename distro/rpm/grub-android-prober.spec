Name:           grub-android-prober
Version:        0.1.6
Release:        1%{?dist}
Summary:        GRUB Configuration for Android detection
License:        GPLv3
URL:            https://github.com/shadichy/grub-android-x86
Source0:        30_android-prober
Source1:        grub-android-prober
Source2:        android-prober.service
Source3:        android-prober@.timer

BuildArch:      noarch
Requires:       grub2-common
Requires:       bash

%description
GRUB Configuration for Android detection (Only works with some sort of filesystems)

%package systemd
Summary:        Systemd timer for grub-android-prober cache refresh
Requires:       %{name} = %{version}-%{release}
Requires:       systemd

%description systemd
This package provides a systemd timer to periodically refresh the
Android Prober cache.

%prep
# Nothing to prep

%build
# Nothing to build

%install
mkdir -p %{buildroot}%{_sysconfdir}/grub.d
mkdir -p %{buildroot}%{_sbindir}
mkdir -p %{buildroot}%{_unitdir}

install -m 755 %{SOURCE0} %{buildroot}%{_sysconfdir}/grub.d/30_android-prober
install -m 755 %{SOURCE1} %{buildroot}%{_sbindir}/grub-android-prober
install -m 644 %{SOURCE2} %{buildroot}%{_unitdir}/android-prober.service
install -m 644 %{SOURCE3} %{buildroot}%{_unitdir}/android-prober@.timer

%post
echo "Running grub-android-prober..."
%{_sbindir}/grub-android-prober

%files
%{_sysconfdir}/grub.d/30_android-prober
%{_sbindir}/grub-android-prober

%files systemd
%{_unitdir}/android-prober.service
%{_unitdir}/android-prober@.timer

%transfiletriggerin -- /usr/lib/modules
/usr/sbin/grub-android-prober || :

%changelog
