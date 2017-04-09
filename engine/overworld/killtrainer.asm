KillTrainer:
	ld hl, wKillTrainerFlags
	ld a, [wKillTrainerIndex]
	ld d, a
	ld a, [wKillTrainerIndex + 1]
	ld e, a
	ld b, FLAG_SET
	call KillTrainerFlagAction
	jp UpdateSprites

IsKillTrainerFlagSet:
	ld hl, wKillTrainerFlags
	ld a, [wKillTrainerIndex]
	ld d, a
	ld a, [wKillTrainerIndex + 1]
	ld e, a
	ld b, FLAG_TEST

KillTrainerFlagAction::
; Perform action b on bit de in flag array hl.

	; get index within the byte
	ld a, e
	and 7

	; shift de right by three bits (get the index within memory)
	srl d
	rr e
	srl d
	rr e
	srl d
	rr e
	add hl, de

	; implement a decoder
	ld c, 1
	rrca
	jr nc, .one
	rlc c
.one
	rrca
	jr nc, .two
	rlc c
	rlc c
.two
	rrca
	jr nc, .three
	swap c
.three

	; check b's value: 0, 1, 2
	ld a, b
	cp 1
	jr c, .clearbit ; 0
	jr z, .setbit ; 1

	; check bit
	ld a, [hl]
	and c
	ld c, a
	ret

.setbit
	; set bit
	ld a, [hl]
	or c
	ld [hl], a
	ret

.clearbit
	; clear bit
	ld a, c
	cpl
	and [hl]
	ld [hl], a
	ret

IsTrainerTombstone:
	ld a, [hSpriteIndexOrTextID]
	swap a
	ld d, $c1
	ld e, a
	ld a, [de]
	cp SPRITE_TOMBSTONE
	ret

IsTrainerKilled:
	ld a, [H_CURRENTSPRITEOFFSET]
	ld d, $c1
	ld e, a
	ld a, [de]
	cp SPRITE_TOMBSTONE
	jr z, .notKilled
.skip
	ld a, e
	swap a
	ld b, a
	ld hl, wKillTrainerList
.loop
	ld a, [hli]
	cp $ff
	jr z, .notKilled
	cp b
	ld a, [hli]
	inc hl
	jr nz, .loop
	dec hl
	ld d, a
	ld a, [hl]
	ld e, a
	ld b, FLAG_TEST
	ld hl, wKillTrainerFlags
	call KillTrainerFlagAction
	ld a, c
	and a
	jr nz, .killed
.notKilled
	xor a
.killed
	ld [$ffe5], a
	ret

LoadTrainers:
	ld hl, MapKTPointers
	ld a, [wCurMap]
	ld b, $0
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [hli]                ; load trainers pointer in hl
	ld h, [hl]
	ld l, a
	push hl
	ld de, MapKT00             ; calculate difference between out pointer and the base pointer
	ld a, l
	sub e
	jr nc, .noCarry
	dec h
.noCarry
	ld l, a
	ld a, h
	sub d
	ld h, a
	ld a, h
	ld [H_DIVIDEND], a
	ld a, l
	ld [H_DIVIDEND+1], a
	xor a
	ld [H_DIVIDEND+2], a
	ld [H_DIVIDEND+3], a
	ld a, $2
	ld [H_DIVISOR], a
	ld b, $2
	call Divide                ; divide difference by 2, resulting in the global offset (number of trainers before ours)
	ld a, [H_DIVIDEND+2]
	ld b, a
	ld a, [H_DIVIDEND+3]
	ld c, a
	pop hl
	push bc
	ld de, wKillTrainerList
.writeKillTrainerListLoop
	ld a, [wCurMap]
	ld b, a
	ld a, [hli]
	cp $ff
	jr z, .done     ; end of list
	cp b
	jr nz, .done    ; not for current map anymore
	xor a
	ld b, a
	ld a, [hli]
	ld [de], a                 ; write (map-local) sprite ID
	inc de
	ld a, b
	ld [de], a                  ; write (global) trainer index first byte
	inc de
	ld a, c
	ld [de], a                  ; write (global) trainer index second byte
	inc de
	pop bc
	inc bc
	push bc
	jr .writeKillTrainerListLoop
.done
	ld a, $ff
	ld [de], a                 ; write sentinel
	pop bc
	ret

PlaceTombstones:
	ld a, $10
.loop
	ld e, a
	ld [H_CURRENTSPRITEOFFSET], a
	push de
	call IsTrainerKilled
	pop de
	ld a, [$ffe5]
	and a
	jr z, .next
	ld d, $c1
	ld a, SPRITE_TOMBSTONE
	ld [de], a
.next
	ld a, e
	or a
	jr z, .end
	add a, $10
	jr .loop
.end
	ret
