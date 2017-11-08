CeladonMansion3Script:
	jp EnableAutoTextBoxDrawing

CeladonMansion3TextPointers:
	dw ProgrammerText
	dw GraphicArtistText
	dw WriterText
	dw DirectorText
	dw GameFreakPCText1
	dw GameFreakPCText2
	dw GameFreakPCText3
	dw GameFreakSignText

ProgrammerText:
	TX_FAR _ProgrammerText
	db "@"

GraphicArtistText:
	TX_FAR _GraphicArtistText
	db "@"

WriterText:
	TX_FAR _WriterText
	db "@"

DirectorText:
	TX_ASM

	; check pokédex
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	cp 150
	jr nc, .CompletedDex
	ld hl, .GameDesigner
	jr .done
.CompletedDex
	ld hl, .CompletedDexText
.done
	call PrintText
	jp TextScriptEnd

.GameDesigner
	TX_FAR _GameDesignerText
	db "@"

.CompletedDexText
	TX_FAR _CompletedDexText
	TX_BLINK
	TX_ASM
	callab DisplayDiploma
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd

GameFreakPCText1:
	TX_ASM
	ld hl, CeladonMansion3Text5
	ld a, [wNumHoFTeams]
	and a
	jr z, .skip
	ld hl, HasntBeenWorkingText
.skip
	call PrintText
	jp TextScriptEnd

GameFreakPCText2:
	TX_ASM
	ld hl, CeladonMansion3Text6
	ld a, [wNumHoFTeams]
	and a
	jr z, .skip
	ld hl, HasntBeenWorkingText
.skip
	call PrintText
	jp TextScriptEnd

GameFreakPCText3:
	TX_ASM
	ld hl, CeladonMansion3Text7
	ld a, [wNumHoFTeams]
	and a
	jr z, .skip
	ld hl, HasntBeenWorkingText
.skip
	call PrintText
	jp TextScriptEnd

CeladonMansion3Text5:
	TX_FAR _CeladonMansion3Text5
	db "@"

CeladonMansion3Text6:
	TX_FAR _CeladonMansion3Text6
	db "@"

CeladonMansion3Text7:
	TX_FAR _CeladonMansion3Text7
	db "@"

GameFreakSignText:
	TX_FAR _CeladonMansion3Text8
	db "@"
