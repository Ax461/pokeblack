HallofFameRoomScript:
	call EnableAutoTextBoxDrawing
	ld hl, HallofFameRoomScriptPointers
	ld a, [wHallOfFameRoomCurScript]
	jp CallFunctionInTable

HallofFameRoomScript_5a4aa:
	xor a
	ld [wJoyIgnore], a
	ld [wHallOfFameRoomCurScript], a
	ret

HallofFameRoomScriptPointers:
	dw HallofFameRoomScript0
	dw HallofFameRoomScript1
	dw HallofFameRoomScript2
	dw HallofFameRoomScript3

HallofFameRoomScript3:
	ret

HallofFameRoomScript2:
	call Delay3
	ld a, [wLetterPrintingDelayFlags]
	push af
	xor a
	ld [wJoyIgnore], a
	predef HallOfFamePC
	pop af
	ld [wLetterPrintingDelayFlags], a
	ld hl, wFlags_D733
	res 1, [hl]
	inc hl
	set 0, [hl]
	xor a
	ld hl, wLoreleiCurScript
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wLanceCurScript], a
	ld [wHallOfFameRoomCurScript], a
	; Elite 4 events
	ResetEventRange ELITE4_EVENTS_START, ELITE4_CHAMPION_EVENTS_END, 1
	ResetEvent EVENT_GOT_POKEDEX
	xor a
	ld [wHallOfFameRoomCurScript], a
	ld [wObtainedBadges], a
	ld [wPartyCount], a
	ld [wNumBagItems], a
	ld [wNumBoxItems], a
	ld [wPlayerMoney], a
	ld [wPlayerMoney + 1], a
	ld [wPlayerMoney + 2], a
	dec a
	ld [wBagItems], a
	ld hl, wObtainedHiddenItemsFlags
	ld bc, wWalkBikeSurfState - wObtainedHiddenItemsFlags
	call FillMemory
	ld b, 5
.delayLoop
	ld c, 600 / 5
	call DelayFrames
	dec b
	jr nz, .delayLoop
	call WaitForTextScrollButtonPress
	ld hl, wKilledMonsPointer
	ld a, [hli]
	ld l, [hl]
	ld h, a
	call EnableSRAM1
	ld a, $ff
	ld [hl], a
	ld hl, wKilledTrainersPointer
	ld a, [hli]
	ld l, [hl]
	ld h, a
	ld a, $ff
	ld [hl], a
	call DisableSRAM1
	call ClearScreen
	ld a, PLAYER_DIR_LEFT << 2
	ld [PlayerFacingDirection], a
	ld a, POKEMONTOWER_2
	ld [wCurMap], a
	ld a, LAVENDER_TOWN
	ld [wLastMap], a
	ld a, $2
	ld [wDestinationWarpID], a
	ld hl, wd430
	set 6, [hl] ; auto save flag
	jp EnterMap

HallofFameRoomScript0:
	callba IsKillTrainerFlagSet
	ret nz
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, RLEMovement5a528
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $1
	ld [wHallOfFameRoomCurScript], a
	ret

RLEMovement5a528:
	db D_UP,$5
	db $ff

HallofFameRoomScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, $1
	ld [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_LEFT
	ld [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call Delay3
	xor a
	ld [wJoyIgnore], a
	inc a ; PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, $1
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, HS_UNKNOWN_DUNGEON_GUY
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, $2
	ld [wHallOfFameRoomCurScript], a
	ret

HallofFameRoomTextPointers:
	dw HallofFameRoomText1

HallofFameRoomText1:
	TX_FAR _HallofFameRoomText1
	db "@"
