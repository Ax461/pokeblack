PlaceTombstones:
	ld a, [wCurMap]
	ld b, a
	ld a, [wTombstoneListMap]
	cp b
	jr nz, .continue
	ld hl, wTombstoneList
.next
	ld a, [hl]
	cp $ff
	jr z, .continue
	ld a, [hli]
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
	ld a, [wWarpFlag]
	and a
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
	call LoadTileBlock
	ld [wNewTileBlockID], a
	push bc
	call ReplaceTileBlock2
	pop bc
	ld a, [wTombstoneListPointer]
	ld h, a
	ld a, [wTombstoneListPointer + 1]
	ld l, a
	ld a, [wBuffer + 3]
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
	xor a
	ld [wWarpFlag], a
	ret

LoadTileBlock:
	ld hl, TombstoneTileBlocks
	ld a, [wBuffer + 1]
	ld d, a
	ld a, [wBuffer + 2]
	ld e, a
	add hl, de
	ld a, [hl]
	ld [wBuffer + 3], a
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
	add hl, bc ; add X
	ld a, [wNewTileBlockID]
	ld [hl], a
	ret
