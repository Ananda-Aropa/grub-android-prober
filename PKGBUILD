# Maintainer: shadichy <shadichy.dev@gmail.com>

pkgname='grub-android-prober-git'
pkgver='0.1.5'
pkgrel='1'
pkgdesc='GRUB Configuration for Android detection (Only works with some sort of filesystems)'
arch=('any')
license=('GPLv3')
url='https://github.com/shadichy/grub-android-x86.git'
depends=('grub' 'bash')
provides=('grub-android-prober')
conflicts=('grub-android-prober')
source=('30_android-prober' 'grub-android-prober')
sha512sums=(	'2a0635a27bb0b88d93d891f957c53638fbbe027dcc9151ac16ba017aa09b277f8fca2315144aa0ef5b4b35f6a0c904e1a8f393521d82e8765df85d9a66a49bff'	'c8db060eaa912cb2f30f13e0051c5c25d08e3684051b75ac1554eef0d6055552fb3a76dd8e87ebdac51cf66a113fb1b92047d4855fd41cf97199ac80ad42e169' )

package() {
	cd "$srcdir"
	install -Dm755 "30_android-prober" "$pkgdir/etc/grub.d/30_android-prober"
	install -Dm755 "grub-android-prober" "$pkgdir/usr/bin/grub-android-prober"
}
