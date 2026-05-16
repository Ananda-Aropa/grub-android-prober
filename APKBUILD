# Maintainer: shadichy <shadichy.dev@gmail.com>
pkgname=grub-android-prober
pkgver=0.1.6
pkgrel=0
pkgdesc="GRUB Configuration for Android detection"
url="https://github.com/shadichy/grub-android-x86"
arch="noarch"
license="GPL-3.0-or-later"
depends="grub bash"
subpackages="$pkgname-systemd:systemd_subpkg"
source="30_android-prober
	grub-android-prober
	VERSION
	android-prober.service
	android-prober@.timer"
install="$pkgname.post-install"

package() {
	install -Dm755 "$srcdir"/30_android-prober "$pkgdir"/etc/grub.d/30_android-prober
	install -Dm755 "$srcdir"/grub-android-prober "$pkgdir"/usr/sbin/grub-android-prober
}

systemd_subpkg() {
	pkgdesc="Systemd timer for grub-android-prober cache refresh"
	depends="$pkgname systemd"
	install -Dm644 "$srcdir"/android-prober.service "$subpkgdir"/usr/lib/systemd/system/android-prober.service
	install -Dm644 "$srcdir"/android-prober@.timer "$subpkgdir"/usr/lib/systemd/system/android-prober@.timer
}

