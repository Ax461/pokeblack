RedsHouse2FScript:
	call EnableAutoTextBoxDrawing
	ld hl,RedsHouse2FScriptPointers
	ld a,[wRedsHouse2CurScript]
	jp CallFunctionInTable

RedsHouse2FScriptPointers:
	dw RedsHouse2FScript0
	dw RedsHouse2FScript1

RedsHouse2FScript0:
	xor a
	ld [hJoyHeld],a
	ld a,PLAYER_DIR_UP
	ld [wPlayerMovingDirection],a
	ld a,1
	ld [wRedsHouse2CurScript],a
	ret

RedsHouse2FScript1:
	ld a, [wNumHoFTeams]
	and a
	ret z
	ld a, [wYCoord]
	cp $6
	ret nz
	ld a, [wXCoord]
	cp $3
	ret nz
	jpba FinalSequence

RedsHouse2FTextPointers:
	db "@"
