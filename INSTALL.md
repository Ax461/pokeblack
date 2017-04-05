# Linux

	sudo apt-get install make gcc bison git python

	git clone https://github.com/rednex/rgbds
	cd rgbds
	sudo make install
	cd ..

	git clone --recursive https://github.com/Ax461/pokeblack
	cd pokeblack

	make


# Mac

In **Terminal**, run:

	xcode-select --install

	git clone https://github.com/rednex/rgbds
	cd rgbds
	sudo make install
	cd ..

	git clone --recursive https://github.com/Ax461/pokeblack
	cd pokeblack

	make


# Windows

To build on Windows, use [**Cygwin**](http://cygwin.com/install.html). Use the default settings.

In the installer, select the following packages: `make` `git` `python` `gettext`

Then get the most recent version of [**rgbds**](https://github.com/bentley/rgbds/releases/).
Extract the archive and put `rgbasm.exe`, `rgblink.exe` and `rgbfix.exe` in `C:\cygwin\usr\local\bin`.

In the **Cygwin terminal**:

	git clone --recursive https://github.com/Ax461/pokeblack
	cd pokeblack

	make
