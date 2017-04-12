;\1 = trainer index
SetKillTrainerIndex: MACRO
	IF \1 == 0
		xor a
		ld [wKillTrainerIndex], a
	ELSE
		ld hl, \1
		ld a, h
		ld [wKillTrainerIndex], a
		ld a, l
	ENDC

		ld [wKillTrainerIndex + 1], a
	ENDM
