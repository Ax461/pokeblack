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

	ld hl, wSpecialDataStart
	ld bc, wSpecialDataEnd - wSpecialDataStart
	call FillMemory

	ld a, $ff
	ld [wTombstoneListMap], a

	ld a, wTombstoneList >> 8
	ld [wTombstoneListPointer], a
	ld a, wTombstoneList & $ff
	ld [wTombstoneListPointer + 1], a

	ld a, sKilledMons >> 8
	ld [wKilledMonsPointer], a
	ld a, sKilledMons & $ff
	ld [wKilledMonsPointer + 1], a

	ld a, sKilledTrainers >> 8
	ld [wKilledTrainersPointer], a
	ld a, sKilledTrainers & $ff
	ld [wKilledTrainersPointer + 1], a

	jp InitializeMissableObjectsFlags

InitializeEmptyList:
	xor a ; count
	ld [hli], a
	dec a ; terminator
	ld [hl], a
	ret
