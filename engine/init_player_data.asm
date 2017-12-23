InitPlayerData:
InitPlayerData2:

	call Random
	ld a, [hRandomSub]
	ld [wPlayerID], a

	call Random
	ld a, [hRandomAdd]
	ld [wPlayerID + 1], a

	ld a, $ff

	ld hl, wPartyCount
	call InitializeEmptyList
	ld hl, wNumInBox
	call InitializeEmptyList
	ld hl, wNumBagItems
	call InitializeEmptyList
	ld hl, wNumBoxItems
	call InitializeEmptyList

START_MONEY EQU $3000
	ld hl, wPlayerMoney + 1
	ld a, START_MONEY / $100
	ld [hld], a
	xor a
	ld [hli], a
	inc hl
	ld [hl], a

	ld [wMonDataLocation], a

	ld hl, wObtainedBadges
	ld [hli], a

	ld [hl], a

	ld hl, wPlayerCoins
	ld [hli], a
	ld [hl], a

	ld hl, wGameProgressFlags
	ld bc, wGameProgressFlagsEnd - wGameProgressFlags
	call FillMemory ; clear all game progress flags

	ld hl, wKillTrainerFlags
	ld bc, wKillTrainerFlagsEnd - wKillTrainerFlags
	call FillMemory

	ld a, $ff
	ld [wTombstoneList], a

	ld hl, wTombstoneList
	ld a, h
	ld [wTombstoneListPointer], a
	ld a, l
	ld [wTombstoneListPointer + 1], a

	ld hl, sKilledMons
	ld a, h
	ld [wKilledMonsPointer], a
	ld a, l
	ld [wKilledMonsPointer + 1], a

	ld hl, sKilledTrainers
	ld a, h
	ld [wKilledTrainersPointer], a
	ld a, l
	ld [wKilledTrainersPointer + 1], a

	jp InitializeMissableObjectsFlags

InitializeEmptyList:
	xor a ; count
	ld [hli], a
	dec a ; terminator
	ld [hl], a
	ret
