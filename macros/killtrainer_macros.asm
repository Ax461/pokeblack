;\1 = trainer index
SetKillTrainerIndex: MACRO
	IF \1 == 0
		xor a
		ld [wKillTrainerIndex], a
	ELSE
		ld a, (\1 >> 8) & $ff
		ld [wKillTrainerIndex], a
		ld a, \1 & $ff
	ENDC
		ld [wKillTrainerIndex + 1], a
	ENDM
