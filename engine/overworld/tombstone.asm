PlaceTombstones:
	ld a, [wCurMap]
	ld b, a
	ld a, [wTombstoneListMap]
	cp b
	jr nz, .continue
	ld hl, wTombstoneList
.next
	ld a, [hli]
	cp $ff
	jr z, .continue
	ld [wNewTileBlockID], a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	push hl
	call ReplaceTileBlock2
	pop hl
	jr .next
.continue
	ld a, [wd430]
	bit 2, a ; warp flag
	ret z
	ld hl, wKillTrainerList
.loop
	ld a, [hli]
	cp $ff
	jr z, .done
	ld [wBuffer], a
	ld a, [hli]
	ld d, a
	ld [wBuffer + 1], a
	ld a, [hli]
	ld e, a
	ld [wBuffer + 2], a
	ld b, FLAG_TEST
	push hl
	ld hl, wKillTrainerFlags
	call KillTrainerFlagAction
	ld a, c
	and a
	jr z, .skip
	ld a, [wBuffer]
	swap a
	add 4
	ld h, $c2
	ld l, a
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	srl b
	srl c
	dec b
	dec b
	dec c
	dec c
	push bc
	push bc
	call LoadTileBlock
	pop bc
	call ReplaceTileBlock2
	pop bc
	ld hl, wTombstoneListPointer
	ld a, [hli]
	ld l, [hl]
	ld h, a
	ld a, [wNewTileBlockID]
	ld [hli], a
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, $ff
	ld [hl], a
	ld a, h
	ld [wTombstoneListPointer], a
	ld a, l
	ld [wTombstoneListPointer + 1], a
	ld a, [wCurMap]
	ld [wTombstoneListMap], a
.skip
	pop hl
	jr .loop
.done
	ld hl, wd430
	res 2, [hl] ; warp flag

; individual map hacks
	ld a, [wCurMap]
	cp CERULEAN_CITY
	jr z, .ceruleanCity
	cp VERMILION_CITY
	jr z, .vermilionCity
	cp ROUTE_17
	jr z, .route17
	cp GAME_CORNER
	jp z, .gameCorner
	cp ROCKET_HIDEOUT_4
	jp z, .rocketHideout4
	ret
.ceruleanCity
	SetKillTrainerIndex KT_ROUTE_24_TRAINER_5
	call IsKillTrainerFlagSet
	ret z
	ld a, $a2
	ld [wOverworldMap + 13], a
	ret
.vermilionCity
	SetKillTrainerIndex KT_ROUTE_6_TRAINER_3
	call IsKillTrainerFlagSet
	ret z
	ld a, $82
	ld [wOverworldMap + 13], a
	SetKillTrainerIndex KT_ROUTE_6_TRAINER_4
	call IsKillTrainerFlagSet
	ret z
	ld a, $85
	ld [wOverworldMap + 13], a
	ret
.route17
	SetKillTrainerIndex KT_ROUTE_16_TRAINER_1
	call IsKillTrainerFlagSet
	ret z
	ld a, $96
	ld [wOverworldMap + 10], a
	ret
.gameCorner
	CheckEvent EVENT_FOUND_ROCKET_HIDEOUT
	ret nz
	ld a, $34
	ld [wOverworldMap + 87], a
	ret
.rocketHideout4
	ld hl, wMissableObjectFlags
	ld c, HS_ROCKET_HIDEOUT_4_ITEM_5
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	ret nz
	ld a, $0e
	ld [wOverworldMap + 92], a
	ret

LoadTileBlock:
	ld hl, TombstoneTileBlocks
	ld a, [wBuffer + 1]
	ld d, a
	ld a, [wBuffer + 2]
	ld e, a
	add hl, de
	ld a, [hl]
	ld [wNewTileBlockID], a

	ld a, [wBuffer]
	ld b, a
	ld a, [wCurMap]
	ld c, a
	ld hl, DoubleTombstoneTileBlocks
.next
	ld a, [hli]
	cp $ff
	ret z
	cp c
	jr z, .checkSpriteID
	ld de, 6
	add hl, de
	jr .next
.checkSpriteID
	ld a, [hli]
	cp b
	jr z, .checkTrainerIndex1
	ld de, 5
	add hl, de
	jr .next
.checkTrainerIndex1
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld hl, wKillTrainerFlags
	ld b, FLAG_TEST
	call KillTrainerFlagAction
	pop hl
	jr nz, .checkTrainerIndex2
	ld de, 3
	add hl, de
	jr .next
.checkTrainerIndex2
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld hl, wKillTrainerFlags
	ld b, FLAG_TEST
	call KillTrainerFlagAction
	pop hl
	jr nz, .done
	inc hl
	jr .next
.done
	ld a, [hl]
	ld [wNewTileBlockID], a
	ret

ReplaceTileBlock2:
	ld hl, wOverworldMap
	ld a, [wCurMapWidth]
	add $6
	ld e, a
	ld d, $0
	add hl, de
	add hl, de
	add hl, de
	ld e, $3
	add hl, de
	ld e, a
	ld a, b
	and a
	jr z, .addX
.addWidthYTimesLoop
	add hl, de
	dec b
	jr nz, .addWidthYTimesLoop
.addX
	add hl, bc
	ld a, [wNewTileBlockID]
	ld [hl], a
	ret
