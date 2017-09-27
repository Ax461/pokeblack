PYTHON := python2.7

2bpp     := $(PYTHON) extras/pokemontools/gfx.py 2bpp
1bpp     := $(PYTHON) extras/pokemontools/gfx.py 1bpp
pic      := $(PYTHON) extras/pokemontools/pic.py compress
includes := $(PYTHON) extras/pokemontools/scan_includes.py

pokeblack_obj := audio.o main.o text.o wram.o

.SUFFIXES:
.SUFFIXES: .asm .o .gb .png .2bpp .1bpp .pic
.SECONDEXPANSION:
# Suppress annoying intermediate file deletion messages.
.PRECIOUS: %.2bpp
.PHONY: all clean black

roms := pokeblack.gb

all: $(roms)
black: pokeblack.gb

clean:
	rm -f $(roms) $(pokeblack_obj) $(roms:.gb=.sym)
	find . \( -iname '*.1bpp' -o -iname '*.2bpp' -o -iname '*.pic' \) -exec rm {} +

%.asm: ;

%.o: dep = $(shell $(includes) $(@D)/$*.asm)
$(pokeblack_obj): %.o: %.asm $$(dep)
	rgbasm -h -o $@ $*.asm

pokeblack_opt  = -jsv -k 01 -l 0x33 -m 0x13 -p 0 -r 03 -t "POKEMON BLACK"

%.gb: $$(%_obj)
	rgblink -n $*.sym -l linkerscript.link -o $@ $^
	rgbfix $($*_opt) $@

%.png:  ;
%.2bpp: %.png  ; @$(2bpp) $<
%.1bpp: %.png  ; @$(1bpp) $<
%.pic:  %.2bpp ; @$(pic)  $<
