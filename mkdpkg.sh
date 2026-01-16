#!/bin/bash

rm -rf Revert-Icons-Mint-Y*

for name in "" "-Aqua" "-Blue" "-Cyan" "-Grey" "-Navy" "-Orange" "-Pink" "-Purple" "-Red" "-Sand" "-Teal" "-Yaru"; do
	icon_name="Revert-Icons-Mint-Y$name"
	mkdir "$icon_name"
	cp index.theme "$icon_name"
	sed -i "s/Name=Revert-Icons-Mint-Y/Name=Revert-Icons-Mint-Y$name/" $icon_name/index.theme
	if [ $name != "" ]; then
		sed -i "s/Inherits=Mint-Y,Adwaita,gnome,hicolor/Inherits=Mint-Y$name,Mint-Y,Adwaita,gnome,hicolor/" $icon_name/index.theme
	fi
	cp -r mint-22.2/* "$icon_name"
done

echo "building debian package"
mkdir -p package/usr/share/icons/
mv Revert-Icons-Mint-Y* package/usr/share/icons/
cp -r DEBIAN package
dpkg-deb --root-owner-group --build "package" > /dev/null
mv package.deb Revert-Icons-Mint-Y.deb
rm -rf package

echo "making tar achive"
tar -czf Revert-Icons-Mint-Y.tar.gz Revert-Icons-Mint-Y*
