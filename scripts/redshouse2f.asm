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

	ld hl, wYCoord
	ld a, [hli]
	cp 6
	ret nz
	ld a, [hl]
	cp 3
	ret nz
	callba FinalSequence
	call _Finale
	ret

_Finale:
	call GBPalBlackOut
	ld a, $FF
	ld [hWY], a
	ld a, $E3		; kinda hacky
	ld [rLCDC], a
	ld a, 7
	ld [rWX], a
	call ClearScreen
	ld c, 100
	call DelayFrames
	ld a, [wd430]
	set 7, a		; final vs. Ghost flag
	ld [wd430], a
	ld a, $1F
	ld [wCurOpponent], a

	ld hl, wPlayerName
	ld de, wBattleMonNick
	ld bc, NAME_LENGTH
	call CopyData

	ld a, 50
	ld [wBattleMonMaxHP+1], a
	ld a, 50
	ld [wBattleMonHP+1], a

	xor a
	ld [wPartyCount],a
	ld hl, wBattleMonMoves
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, wBattleMonPP
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld a, 20
	ld [wCurEnemyLVL], a
	ld [wBattleMonLevel], a
	ret

RedsHouse2FTextPointers:
	db "@"
