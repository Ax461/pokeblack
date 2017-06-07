# Linux

	git clone https://github.com/Ax461/pokeblack
	cd pokeblack

	make


# Mac

In **Terminal**, run:

	xcode-select --install

	git clone https://github.com/rednex/rgbds
	cd rgbds
	git checkout v0.2.5
	make
	cp rgbasm rgblink rgbfix ../rgbds
	cd ..

	git clone https://github.com/Ax461/pokeblack
	cd pokeblack

	make


# Windows

To build on Windows, use [**Cygwin**](http://cygwin.com/install.html). Use the default settings.

In the installer, select the following packages: `make` `git` `python` `gettext`

Then get [**rgbds 0.2.5**](https://github.com/bentley/rgbds/releases/tag/v0.2.5).
Extract the archive and put `rgbasm.exe`, `rgblink.exe` and `rgbfix.exe` in `pokeblack\rgbds`.
Change the line in Makefile starting with `EXE :=`  to `EXE := .exe`

In the **Cygwin terminal**:

	git clone https://github.com/Ax461/pokeblack
	cd pokeblack

	make
