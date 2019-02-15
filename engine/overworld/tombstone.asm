PlaceTombstones:
	call ReplaceTileBlocks
	ret c
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
	bit 3, a ; warp flag
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
	res 3, [hl] ; warp flag
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

ReplaceTileBlocks:
	ld a, [wNumHoFTeams]
	and a
	ret z
	ld a, [wCurMap]
	cp ROUTE_2
	jr z, .route2
	ld a, [wCurMap]
	cp VIRIDIAN_SCHOOL
	jr z, .viridianSchool
	cp VERMILION_DOCK
	jr z, .vermilionDock
	or a
	ret
.route2
	ld a, $6d
	ld [wOverworldMap + 133], a
	jr .done
.viridianSchool
	ld a, $23
	ld [wOverworldMap + 44], a
	ld a, $24
	ld [wOverworldMap + 54], a
	jr .done
.vermilionDock
	ld a, $17
	ld [wOverworldMap + 90], a
	ld a, $01
	ld [wOverworldMap + 88], a
	ld [wOverworldMap + 91], a
	ld a, $0d
	ld [wOverworldMap + 89], a
	ld [wOverworldMap + 108], a
	ld [wOverworldMap + 109], a
	ld [wOverworldMap + 110], a
	ld [wOverworldMap + 111], a
.done
	scf
	ret

LoadTileBlock:
	ld hl, TombstoneTileBlocks - 1
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
	add 6
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	ld e, 3
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

ReplaceTiles:
	ld a, [wCurMap]
	cp ROUTE_10
	jr nz, .checkPokecenter
	ld hl, TombstonesAlt_GFX
	ld de, vTileset + $680
	ld bc, $40
	jp CopyData
.checkPokecenter
	ld a, [wNumHoFTeams]
	and a
	ret z
	ld a, [wCurMapTileset]
	cp POKECENTER
	ret nz
	ld hl, PokecenterAlt_GFX
	ld de, vTileset + $240
	ld bc, $20
	call CopyData
	ld de, vTileset + $390
	ld bc, $10
	call CopyData
	ld de, vTileset + $340
	ld bc, $20
	call CopyData
	ld de, vTileset + $3c0
	ld bc, $10
	jp CopyData
