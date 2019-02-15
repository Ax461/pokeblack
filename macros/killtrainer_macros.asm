;\1 = trainer index
SetKillTrainerIndex: MACRO
	IF \1 == 0
		xor a
		ld [wKillTrainerIndex], a
	ELSE
		IF \1 <= $ff
			xor a
		ELSE
			ld a, \1 >> 8
		ENDC
		ld [wKillTrainerIndex], a
		ld a, \1 & $ff
	ENDC
		ld [wKillTrainerIndex + 1], a
	ENDM

;\1 = KillTrainer index
CheckKillTrainerFlag: MACRO
killtrainer_byte = ((\1) / 8)
	ld a, [wKillTrainerFlags + killtrainer_byte]
	bit (\1) % 8, a
	ENDM
