#!/bin/bash

set -x
set -e

ALLEGRO_VERSION=5.2.3.0
DEPS_VERSION=1.6.0
GCC_VERSION=7.2.0

make_deps_package() {
	# $1 - path to copy from
	# $2 - output prefix

	DEST=allegro_deps

	rm -Rf $DEST
	mkdir -p $DEST
	cp -r ../$1/* $DEST
	7z a -r -tzip -mx=9 ../$2-$DEPS_VERSION.zip $DEST
}

make_allegro_package() {
	# $1 - path to copy from
	# $2 - output prefix

	DEST=allegro

	rm -Rf $DEST
	mkdir -p $DEST
	cp -r ../$1/* $DEST
	echo $DEPS_VERSION > $DEST/allegro_deps_version.txt
	7z a -r -tzip -mx=9 ../$2-$ALLEGRO_VERSION.zip $DEST
}

STAGING=msys_package

rm -rf $STAGING
mkdir -p $STAGING
cd $STAGING

make_deps_package allegro_deps_msys_32 allegro_deps-i686-w64-mingw32-gcc-$GCC_VERSION-posix-dwarf
make_deps_package allegro_deps_msys_64 allegro_deps-x86_64-w64-mingw32-gcc-$GCC_VERSION-posix-seh

make_allegro_package allegro_msys_32/dynamic_rt allegro-i686-w64-mingw32-gcc-$GCC_VERSION-posix-dwarf-dynamic
make_allegro_package allegro_msys_32/static_rt allegro-i686-w64-mingw32-gcc-$GCC_VERSION-posix-dwarf-static
make_allegro_package allegro_msys_64/dynamic_rt allegro-x86_64-w64-mingw32-gcc-$GCC_VERSION-posix-seh-dynamic
make_allegro_package allegro_msys_64/static_rt allegro-x86_64-w64-mingw32-gcc-$GCC_VERSION-posix-seh-static
