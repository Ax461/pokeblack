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

	ld a, [wCurMap]
	ld b, a
	ld hl, ConnectionTombstoneTileBlocks
.next2
	ld a, [hli]
	cp $ff
	ret z
	cp b
	jr z, .checkTrainerIndex
	ld de, 4
	add hl, de
	jr .next2
.checkTrainerIndex
	call IsKillTrainerFlagInHLSet
	jr nz, .found
	inc hl
	inc hl
	jr .next2
.found
	ld a, [hli]
	ld c, a
	ld a, [hli]
	push hl
	ld h, 0
	ld l, a
	ld de, wOverworldMap
	add hl, de
	ld a, c
	ld [hl], a
	pop hl
	jr .next2

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
	call IsKillTrainerFlagInHLSet
	jr nz, .checkTrainerIndex2
	ld de, 3
	add hl, de
	jr .next
.checkTrainerIndex2
	call IsKillTrainerFlagInHLSet
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
