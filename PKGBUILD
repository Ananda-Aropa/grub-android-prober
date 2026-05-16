# Maintainer: shadichy <shadichy.dev@gmail.com>

pkgbase='grub-android-prober'
pkgname=('grub-android-prober' 'grub-android-prober-systemd')
pkgver=0.1.6
pkgrel=1
pkgdesc='GRUB Configuration for Android detection (Only works with some sort of filesystems)'
arch=('any')
license=('GPLv3')
url='https://github.com/shadichy/grub-android-x86.git'
depends=('grub' 'bash')
makedepends=('git')
source=('30_android-prober' 'grub-android-prober' 'VERSION' 'android-prober.service' 'android-prober@.timer')
sha512sums=('f010ddfbf2b6d73f53bd6945eb24a191113ce796b23b52c398d8b9223e6c8d2c1e8c0364aa74b37e7460869b01b544279a2d3a16a6f1fdb6e3aaeb71935132ae' '5a99c5b154c518f9024de516aef6f6cdfca11592312e7ebde8feb681c87d13fbf67ca5cac210a4b26920d50078a9ee9aa3ed430f94b4860ac67e0846e48bc85c' '828fdbaea44fe342d925bf7942fe5ced905d6f684c0aadd239d6f0928b62640449b7f4baeeca57dbadde020cf69143d2de8fb7c7fbfb42b99299cbc8bd8f959a' '359cac13caac8baedfb85e2a094c144a696db626d92b716171185d788db30f0861b5231d11f2d466aa8a846e9b8d7919b33ffb4a0db94a3cfb5efce63a0788c1' 'de1d580fd8ff87f78bc599248c5b27d8c9600641a35c6f774c83fdf8a2f1a6374ff260e3d7c9a9c99f614caf7e82a4cb3b49b345a91f46c6ef02ede590ca4f8c' )

pkgver() {
	cat VERSION | sed 's/^v//;s/-/+/g'
}

package_grub-android-prober() {
	depends=('grub' 'bash')
	provides=('grub-android-prober')
	conflicts=('grub-android-prober')

	install -Dm755 "30_android-prober" "$pkgdir/etc/grub.d/30_android-prober"
	install -Dm755 "grub-android-prober" "$pkgdir/usr/bin/grub-android-prober"
}

package_grub-android-prober-systemd() {
	pkgdesc='Systemd timer for grub-android-prober cache refresh'
	depends=('grub-android-prober' 'systemd')

	install -Dm644 "android-prober.service" "$pkgdir/usr/lib/systemd/system/android-prober.service"
	install -Dm644 "android-prober@.timer" "$pkgdir/usr/lib/systemd/system/android-prober@.timer"
}
