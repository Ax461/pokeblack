TARGET_PITCH EQU $24
DECREASE_TEMPO_STEP EQU 5

FinalSequence:
	xor a
	ld [hSCX], a
	ld [hSCY], a
	ld a, 4
	ld [hWY], a
	add 7
	ld [rWX], a		; center the screen view
	ld [hAutoBGTransferEnabled], a
	ld hl, rLCDC
	set 3, [hl]
	call GBPalBlackOut
	call ClearScreen
	call UpdateSprites
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $6b
	call FillMemory	; black out the screen
	ld c, 60
	call DelayFrames
	call GBPalNormal
	coord hl, 6, 5
	xor a
	lb bc, 7, 7
	ld de, SCREEN_WIDTH
.y
	push bc
	push hl
.x
	ld [hli], a
	inc a
	dec c
	jr nz, .x
	pop hl
	add hl, de
	pop bc
	dec b
	jr nz, .y
	ld a, [wKilledEntitiesCounter + 1]
	ld [hDividend], a
	ld a, [wKilledEntitiesCounter]
	ld [hDividend + 1], a
	xor a
	ld [hDividend + 2], a
	ld [hDividend + 3], a
	ld a, TARGET_PITCH
	ld [hDivisor], a
	ld b, 2
	call Divide
	ld a, [hDividend + 3]
	ld [wDecreasePitchInterval], a
	ld a, 1
	ld [wDecreasePitchCounter], a
	call EnableSRAM1
	call DisplayKilledMons
	jr DisplayKilledTrainers

DisplayKilledMons:
	ld hl, sKilledMons
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wWholeScreenPaletteMonSpecies], a
	dec a
	ld hl, BlackPokemon
	ld bc, 3		; pointer size
	call AddNTimes
	call PlaceSprite
	ld b, SET_PAL_POKEMON_WHOLE_SCREEN
	call SetPaletteAndDelay
	call IncreasePitchModifier
	pop hl
	jr .loop

DisplayKilledTrainers:
	ld hl, sKilledTrainers
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	dec a
	ld hl, BlackTrainers
	ld bc, 3
	call AddNTimes
	call PlaceSprite
	ld b, SET_PAL_GENERIC
	call SetPaletteAndDelay
	call IncreasePitchModifier
	pop hl
	jr .loop

PlaceSprite:
	ld c, 7 * 7
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	ld hl, vFrontPic
	jp CopyVideoData

IncreasePitchModifier:
	ld a, [wMusicPitchModifier]
	cp TARGET_PITCH
	ret z
	ld a, [wDecreasePitchInterval]
	ld b, a
	ld a, [wDecreasePitchCounter]
	cp b
	jr nz, .incrementPitchCounter
	ld hl, wMusicPitchModifier
	inc [hl]
	ld hl, wMusicTempo
	ld a, [hli]
	ld l, [hl]
	ld h, a
	ld de, DECREASE_TEMPO_STEP
	add hl, de
	ld a, h
	ld [wMusicTempo], a
	ld a, l
	ld [wMusicTempo + 1], a
	xor a
.incrementPitchCounter
	inc a
	ld [wDecreasePitchCounter], a
	ret

SetPaletteAndDelay:
	ld c, 22
	ld a, [wOnSGB]
	and a
	jr z, .continue
	ld c, 0
	call RunPaletteCommand
	ld c, 12
.continue
	jp DelayFrames
