pokeblack_obj := audio.o main.o text.o wram.o

.SUFFIXES:
.SECONDEXPANSION:
.PRECIOUS:
.SECONDARY:
.PHONY: all clean black

roms := pokeblack.gb

all: $(roms)
black: pokeblack.gb

clean:
	rm -f $(roms) $(pokeblack_obj) $(roms:.gb=.sym)
	find . \( -iname '*.1bpp' -o -iname '*.2bpp' -o -iname '*.pic' \) -exec rm {} +
	$(MAKE) clean -C tools/

tools:
	$(MAKE) -C tools/


# Build tools when building the rom.
# This has to happen before the rules are processed, since that's when scan_includes is run.
ifeq (,$(filter clean tools,$(MAKECMDGOALS)))
$(info $(shell $(MAKE) -C tools))
endif


%.asm: ;

%.o: dep = $(shell tools/scan_includes $(@D)/$*.asm)
$(pokeblack_obj): %.o: %.asm $$(dep)
	rgbasm -E -h -o $@ $*.asm

pokeblack_opt  = -jsv -k 01 -l 0x33 -m 0x13 -p 0 -r 03 -t "POKEMON BLACK"

%.gb: $$(%_obj)
	rgblink -n $*.sym -l linkerscript.link -o $@ $^
	rgbfix $($*_opt) $@
	sort $*.sym -o $*.sym

gfx/intro_nido_1.2bpp: rgbgfx += -h
gfx/intro_nido_2.2bpp: rgbgfx += -h
gfx/intro_nido_3.2bpp: rgbgfx += -h

gfx/game_boy.2bpp: tools/gfx += --remove-duplicates
gfx/theend.2bpp: tools/gfx += --interleave --png=$<
gfx/tilesets/%.2bpp: tools/gfx += --trim-whitespace

%.png: ;

%.2bpp: %.png
	rgbgfx $(rgbgfx) -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -o $@ $@)
%.1bpp: %.png
	rgbgfx -d1 $(rgbgfx) -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -d1 -o $@ $@)
%.pic:  %.2bpp
	tools/pkmncompress $< $@
