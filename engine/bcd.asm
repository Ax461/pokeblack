DivideBCDPredef::
DivideBCDPredef2::
DivideBCDPredef3::
DivideBCDPredef4::
	call GetPredefRegisters

DivideBCD::
	xor a
	ld [hDivideBCDBuffer], a
	ld [hDivideBCDBuffer+1], a
	ld [hDivideBCDBuffer+2], a
	ld d, $1
.mulBy10Loop 
; multiply the divisor by 10 until the leading digit is nonzero
; to set up the standard long division algorithm
	ld a, [hDivideBCDDivisor]
	and $f0
	jr nz, .next
	inc d
	ld a, [hDivideBCDDivisor]
	swap a
	and $f0
	ld b, a
	ld a, [hDivideBCDDivisor+1]
	swap a
	ld [hDivideBCDDivisor+1], a
	and $f
	or b
	ld [hDivideBCDDivisor], a
	ld a, [hDivideBCDDivisor+1]
	and $f0
	ld b, a
	ld a, [hDivideBCDDivisor+2]
	swap a
	ld [hDivideBCDDivisor+2], a
	and $f
	or b
	ld [hDivideBCDDivisor+1], a
	ld a, [hDivideBCDDivisor+2]
	and $f0
	ld [hDivideBCDDivisor+2], a
	jr .mulBy10Loop
.next
	push de
	push de
	call DivideBCD_getNextDigit
	pop de
	ld a, b
	swap a
	and $f0
	ld [hDivideBCDBuffer], a
	dec d
	jr z, .next2
	push de
	call DivideBCD_divDivisorBy10
	call DivideBCD_getNextDigit
	pop de
	ld a, [hDivideBCDBuffer]
	or b
	ld [hDivideBCDBuffer], a
	dec d
	jr z, .next2
	push de
	call DivideBCD_divDivisorBy10
	call DivideBCD_getNextDigit
	pop de
	ld a, b
	swap a
	and $f0
	ld [hDivideBCDBuffer+1], a
	dec d
	jr z, .next2
	push de
	call DivideBCD_divDivisorBy10
	call DivideBCD_getNextDigit
	pop de
	ld a, [hDivideBCDBuffer+1]
	or b
	ld [hDivideBCDBuffer+1], a
	dec d
	jr z, .next2
	push de
	call DivideBCD_divDivisorBy10
	call DivideBCD_getNextDigit
	pop de
	ld a, b
	swap a
	and $f0
	ld [hDivideBCDBuffer+2], a
	dec d
	jr z, .next2
	push de
	call DivideBCD_divDivisorBy10
	call DivideBCD_getNextDigit
	pop de
	ld a, [hDivideBCDBuffer+2]
	or b
	ld [hDivideBCDBuffer+2], a
.next2
	ld a, [hDivideBCDBuffer]
	ld [hDivideBCDQuotient], a ; the same memory location as hDivideBCDDivisor
	ld a, [hDivideBCDBuffer+1]
	ld [hDivideBCDQuotient+1], a
	ld a, [hDivideBCDBuffer+2]
	ld [hDivideBCDQuotient+2], a
	pop de
	ld a, $6 
	sub d
	and a
	ret z
.divResultBy10loop
	push af
	call DivideBCD_divDivisorBy10
	pop af
	dec a
	jr nz, .divResultBy10loop
	ret

DivideBCD_divDivisorBy10:
	ld a, [hDivideBCDDivisor+2]
	swap a
	and $f
	ld b, a
	ld a, [hDivideBCDDivisor+1]
	swap a
	ld [hDivideBCDDivisor+1], a
	and $f0
	or b
	ld [hDivideBCDDivisor+2], a
	ld a, [hDivideBCDDivisor+1]
	and $f
	ld b, a
	ld a, [hDivideBCDDivisor]
	swap a
	ld [hDivideBCDDivisor], a
	and $f0
	or b
	ld [hDivideBCDDivisor+1], a
	ld a, [hDivideBCDDivisor]
	and $f
	ld [hDivideBCDDivisor], a
	ret

DivideBCD_getNextDigit:
	ld bc, $3
.loop
	ld de, hMoney ; the dividend
	ld hl, hDivideBCDDivisor
	push bc
	call StringCmp
	pop bc
	ret c
	inc b
	ld de, hMoney+2 ; since SubBCD works starting from the least significant digit
	ld hl, hDivideBCDDivisor+2  
	push bc
	call SubBCD
	pop bc
	jr .loop


AddBCDPredef::
	call GetPredefRegisters

AddBCD::
	and a
	ld b, c
.add
	ld a, [de]
	adc [hl]
	daa
	ld [de], a
	dec de
	dec hl
	dec c
	jr nz, .add
	jr nc, .done
	ld a, $99
	inc de
.fill
	ld [de], a
	inc de
	dec b
	jr nz, .fill
.done
	ret


SubBCDPredef::
	call GetPredefRegisters

SubBCD::
	and a
	ld b, c
.sub
	ld a, [de]
	sbc [hl]
	daa
	ld [de], a
	dec de
	dec hl
	dec c
	jr nz, .sub
	jr nc, .done
	ld a, $00
	inc de
.fill
	ld [de], a
	inc de
	dec b
	jr nz, .fill
	scf
.done
	ret


; function to print a BCD (Binary-coded decimal) number
; de = address of BCD number
; hl = destination address
; c = flags and length
; bit 7: if set, do not print leading zeroes
;        if unset, print leading zeroes
; bit 6: if set, left-align the string (do not pad empty digits with spaces)
;        if unset, right-align the string
; bit 5: if set, print currency symbol at the beginning of the string
;        if unset, do not print the currency symbol
; bits 0-4: length of BCD number in bytes
; Note that bits 5 and 7 are modified during execution. The above reflects
; their meaning at the beginning of the functions's execution.
PrintBCDNumberPredef::
	call GetPredefRegisters

PrintBCDNumber::
	ld b,c ; save flags in b
	res 7,c
	res 6,c
	res 5,c ; c now holds the length
	bit 5,b
	jr z,.loop
	bit 7,b
	jr nz,.loop
	ld [hl],"¥"
	inc hl
.loop
	ld a,[de]
	swap a
	call PrintBCDDigit ; print upper digit
	ld a,[de]
	call PrintBCDDigit ; print lower digit
	inc de
	dec c
	jr nz,.loop
	bit 7,b ; were any non-zero digits printed?
	jr z,.done ; if so, we are done
.numberEqualsZero ; if every digit of the BCD number is zero
	bit 6,b ; left or right alignment?
	jr nz,.skipRightAlignmentAdjustment
	dec hl ; if the string is right-aligned, it needs to be moved back one space
.skipRightAlignmentAdjustment
	bit 5,b
	jr z,.skipCurrencySymbol
	ld [hl],"¥"
	inc hl
.skipCurrencySymbol
	ld [hl],"0"
	call PrintLetterDelay
	inc hl
.done
	ret

PrintBCDDigit::
	and $f
	and a
	jr z,.zeroDigit
.nonzeroDigit
	bit 7,b ; have any non-space characters been printed?
	jr z,.outputDigit
; if bit 7 is set, then no numbers have been printed yet
	bit 5,b ; print the currency symbol?
	jr z,.skipCurrencySymbol
	ld [hl],"¥"
	inc hl
	res 5,b
.skipCurrencySymbol
	res 7,b ; unset 7 to indicate that a nonzero digit has been reached
.outputDigit
	add "0"
	ld [hli],a
	jp PrintLetterDelay
.zeroDigit
	bit 7,b ; either printing leading zeroes or already reached a nonzero digit?
	jr z,.outputDigit ; if so, print a zero digit
	bit 6,b ; left or right alignment?
	ret nz
	inc hl ; if right-aligned, "print" a space by advancing the pointer
	ret
