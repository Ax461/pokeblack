GhostBattle:
	StopAllMusic
	xor a
	ld [hWY], a
	add 7
	ld [rWX], a
	ld hl, rLCDC
	res 3, [hl]
	call GBPalBlackOut
	call ClearScreen
	ld c, 60
	call DelayFrames
	ld c, BANK(Music_GhostBattle)
	ld a, MUSIC_GHOST_BATTLE
	call PlayMusic
	ld hl, wLetterPrintingDelayFlags
	res 1, [hl]
	call InitGhostBattleVariablesAndData
	call LoadGhostPic
	call SlidePlayerAndGhostSilhouettesOnScreen
	callba DrawAllPokeballs
	ld hl, GhostWantsToFightText
	call PrintText
	callba PrintEmptyString
	coord hl, 9, 7
	lb bc, 5, 10
	call ClearScreenArea
	call ClearSprites
	callba DrawEnemyHUDAndHPBar
	call SaveScreenTilesToBuffer1
	ld c, 50
	call DelayFrames

DisplayGhostBattleMenu:
	call LoadScreenTilesFromBuffer1
	call DrawPlayerHUDAndHPBar2
	callba PrintEmptyString
	ld a, BATTLE_MENU_TEMPLATE
	ld [wTextBoxID], a
	call DisplayTextBoxID
.handleBattleMenuInput
	ld a, [wBattleAndStartSavedMenuItem]
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	sub 2
	jr c, .leftColumn
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	jr .rightColumn
.leftColumn
	ld a, " "
	Coorda 15, 14
	Coorda 15, 16
	ld hl, wTopMenuItemY
	ld a, $e
	ld [hli], a
	ld a, $9
	ld [hli], a
	inc hl
	inc hl
	ld a, $1
	ld [hli], a
	ld [hl], D_RIGHT | A_BUTTON
	call HandleMenuInput
	bit 4, a
	jr z, .AButtonPressed
.rightColumn
	ld a, " "
	Coorda 9, 14
	Coorda 9, 16
	ld hl, wTopMenuItemY
	ld a, $e
	ld [hli], a
	ld a, $f
	ld [hli], a
	inc hl
	inc hl
	ld a, $1
	ld [hli], a
	ld a, D_LEFT | A_BUTTON
	ld [hli], a
	call HandleMenuInput
	bit 5, a
	jr nz, .leftColumn
	ld a, [wCurrentMenuItem]
	add 2
	ld [wCurrentMenuItem], a
.AButtonPressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	ld [wBattleAndStartSavedMenuItem], a
	cp 1
	jr z, .itemMenu
	cp 2
	jp z, .done
	cp 3
	jr z, .run
	ld hl, PlayerUsedStruggleText
	call PrintText
	ld a, 5
	ld [wAnimationType], a
	ld a, STRUGGLE
	ld [wAnimationID], a
	call Delay3
	predef MoveAnimation
	call AnimatePlayerHPBar
	ld hl, PlayerHitWithRecoilText
	call PrintText
	ld a, [wPlayerHPBarColor]
	cp HP_BAR_RED
	jr nz, .continue
	ld hl, GhostUsedCurseText
	call PrintText
	ld c, 30
	call DelayFrames
	call GBPalBlackOut
	callba ClearSAV
	di
.continue
	ld hl, GhostThreeDotsText
	call PrintText
	jr .done
.itemMenu
	ld hl, wNumBagItems
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	callba PrintEmptyString
	xor a
	ld [wPrintItemPrices], a
	ld a, ITEMLISTMENU
	ld [wListMenuID], a
	ld a, [wBagSavedMenuItem]
	ld [wCurrentMenuItem], a
	call DisplayListMenuID
	ld a, [wCurrentMenuItem]
	ld [wBagSavedMenuItem], a
	xor a
	ld [wMenuWatchMovingOutOfBounds], a
	jr .done
.run
	ld hl, CantEscapeText2
	call PrintText
.done
	jp DisplayGhostBattleMenu

SlidePlayerAndGhostSilhouettesOnScreen:
	callba LoadPlayerBackPic
	ld a, MESSAGE_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	coord hl, 1, 5
	lb bc, 3, 7
	call ClearScreenArea
	call DisableLCD
	call LoadFontTilePatterns
	ld hl, vBGMap0
	ld bc, $400
.clearBackgroundLoop
	ld a, " "
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .clearBackgroundLoop
	coord hl, 0, 0
	ld de, vBGMap0
	ld b, 18
.copyRowLoop
	ld c, 20
.copyColumnLoop
	ld a, [hli]
	ld [de], a
	inc e
	dec c
	jr nz, .copyColumnLoop
	ld a, 12
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	dec b
	jr nz, .copyRowLoop
	call EnableLCD
	ld a, $90
	ld [hWY], a
	ld [rWY], a
	xor a
	ld [hSCY], a
	ld [hAutoBGTransferEnabled], a
	dec a
	ld [wUpdateSpritesEnabled], a
	call Delay3
	ld bc, $7090
	ld a, c
	ld [hSCX], a
	call DelayFrame
	ld a, %11100100
	ld [rBGP], a
	ld [rOBP0], a
	ld [rOBP1], a
.slideSilhouettesLoop
	ld h, b
	ld l, $40
	call SetScrollXForSlidingPlayerBodyLeft2
	inc b
	inc b
	ld hl, $0060
	call SetScrollXForSlidingPlayerBodyLeft2
	call SlidePlayerHeadLeft2
	ld a, c
	ld [hSCX], a
	dec c
	dec c
	jr nz, .slideSilhouettesLoop
	ld a, 1
	ld [hAutoBGTransferEnabled], a
	coord hl, 1, 5
	predef CopyUncompressedPicToTilemap
	xor a
	ld [hWY], a
	ld [rWY], a
	call Delay3
	ld a, GHOST
	ld [wEnemyMonSpecies2], a
	ld b, SET_PAL_BATTLE
	jp RunPaletteCommand

SlidePlayerHeadLeft2:
	push bc
	ld hl, wOAMBuffer + 1
	ld c, $15
	ld de, $4
.loop
	dec [hl]
	dec [hl]
	add hl, de
	dec c
	jr nz, .loop
	pop bc
	ret

SetScrollXForSlidingPlayerBodyLeft2:
	ld a, [rLY]
	cp l
	jr nz, SetScrollXForSlidingPlayerBodyLeft2
	ld a, h
	ld [rSCX], a
.loop
	ld a, [rLY]
	cp h
	jr z, .loop
	ret

LoadGhostPic:
	callba LoadHudAndHpBarAndStatusTilePatterns
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld hl, wMonHSpriteDim
	ld a, $66
	ld [hli], a
	ld bc, GhostPicFront
	ld a, c
	ld [hli], a
	ld [hl], b
	ld a, GHOST
	ld [wcf91], a
	ld de, vFrontPic
	call LoadMonFrontSprite
	coord hl, 12, 0
	predef CopyUncompressedPicToTilemap
	ld b, SET_PAL_BATTLE_BLACK
	jp RunPaletteCommand

AnimatePlayerHPBar:
	xor a
	ld [wHPBarMaxHP + 1], a
	ld [wHPBarOldHP + 1], a
	ld [wHPBarNewHP + 1], a
	inc a
	ld [wHPBarType], a
	ld a, 20
	ld [wHPBarMaxHP], a
	ld a, [wBattleMonHP + 1]
	ld [wHPBarOldHP], a
	sub 3
	ld [wBattleMonHP + 1], a
	ld [wHPBarNewHP], a
	coord hl, 10, 9
	predef UpdateHPBar

DrawPlayerHUDAndHPBar2:
	xor a
	ld [hAutoBGTransferEnabled], a
	coord hl, 9, 7
	lb bc, 5, 11
	call ClearScreenArea
	callba PlacePlayerHUDTiles
	coord hl, 18, 9
	ld [hl], $73
	ld de, wPlayerName
	coord hl, 10, 7
	call PlaceString
	ld hl, wBattleMonSpecies
	ld de, wLoadedMon
	ld bc, wBattleMonDVs - wBattleMonSpecies
	call CopyData
	ld hl, wBattleMonLevel
	ld de, wLoadedMonLevel
	ld bc, wBattleMonPP - wBattleMonLevel
	call CopyData
	coord hl, 10, 9
	predef DrawHP
	ld a, 1
	ld [hAutoBGTransferEnabled], a
	ld hl, wPlayerHPBarColor
	ld b, [hl]
	call GetHealthBarColor
	ld a, [hl]
	cp b
	ret z
	ld b, SET_PAL_BATTLE
	jp RunPaletteCommand

InitGhostBattleVariablesAndData:
	xor a
	ld [wBattleMonSpecies], a
	ld [wBattleAndStartSavedMenuItem], a
	ld [hStartTileID], a
	ld [wBattleMonHP], a
	ld [wBattleMonMaxHP], a
	inc a
	ld [wIsInBattle], a
	ld hl, wPlayerHPBarColor
	ld [hli], a
	ld [hl], a
	ld a, 20
	ld [wBattleMonHP + 1], a
	ld [wBattleMonMaxHP + 1], a
	ld hl, wPartyMons
	ld bc, wPartyMon2 - wPartyMon1
.nextMon
	ld a, [hl]
	cp GHOST
	jr z, .found
	add hl, bc
	jr .nextMon
.found
	push hl
	push hl
	ld a, [hl]
	ld [wd11e], a
	call GetMonName
	ld hl, wcd6d
	ld de, wEnemyMonNick
	ld bc, 6
	call CopyData
	pop hl
	ld de, wEnemyMon
	ld bc, wEnemyMonDVs - wEnemyMonSpecies
	call CopyData
	pop hl
	ld de, wPartyMon1Level - wPartyMon1
	add hl, de
	ld de, wEnemyMonLevel
	ld bc, wBattleMonPP - wBattleMonLevel
	jp CopyData

GhostWantsToFightText:
	TX_FAR _GhostWantsToFightText
	db "@"

GhostThreeDotsText:
	TX_FAR _GhostThreeDotsText
	db "@"

GhostUsedCurseText:
	TX_FAR _GhostUsedCurseText
	db "@"

PlayerUsedStruggleText:
	TX_FAR _PlayerUsedStruggleText
	db "@"

PlayerHitWithRecoilText:
	TX_FAR _PlayerHitWithRecoilText
	db "@"

CantEscapeText2:
	TX_FAR _CantEscapeText
	db "@"
