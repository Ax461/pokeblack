Route18GateUpstairsScript:
	jp DisableAutoTextBoxDrawing

Route18GateUpstairsTextPointers:
	dw Route18GateUpstairsText1
	dw Route18GateUpstairsText2
	dw Route18GateUpstairsText3

Route18GateUpstairsText1:
	TX_ASM
	ld a, $5
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd

Route18GateUpstairsText2:
	TX_ASM
	ld hl, Route18GateUpstairsText_49993
	jp GateUpstairsScript_PrintIfFacingUp

Route18GateUpstairsText_49993:
	TX_FAR _Route18GateUpstairsText_49993
	db "@"

Route18GateUpstairsText3:
	TX_ASM
	ld hl, Route18GateUpstairsText_4999f
	ld a, [wNumHoFTeams]
	and a
	jr z, .end
	ld hl, Route18GateUpstairsText_4999fAlt
.end
	jp GateUpstairsScript_PrintIfFacingUp

Route18GateUpstairsText_4999f:
	TX_FAR _Route18GateUpstairsText_4999f
	db "@"

Route18GateUpstairsText_4999fAlt:
	TX_FAR _Route18GateUpstairsText_4999fAlt
	db "@"
