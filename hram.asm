hSoftReset EQU $FF8A
; Initialized to 16.
; Decremented each input iteration if the player
; presses the reset sequence (A+B+SEL+START).
; Soft reset when 0 is reached.

; base tile ID to which offsets are added
hBaseTileID EQU $FF8B

; 3-byte BCD number
hItemPrice EQU $FF8B

hDexWeight EQU $FF8B

hWarpDestinationMap EQU $FF8B

hOAMTile EQU $FF8B

hROMBankTemp EQU $FF8B

hPreviousTileset EQU $FF8B

hEastWestConnectedMapWidth EQU $FF8B

hSlideAmount EQU $FF8B

hRLEByteValue EQU $FF8B

hSpriteWidth            EQU $FF8B ; in tiles
hSpriteInterlaceCounter EQU $FF8B
hSpriteHeight           EQU $FF8C ; in tiles
hSpriteOffset           EQU $FF8D

; counters for blinking down arrow
hDownArrowBlinkCnt1 EQU $FF8B
hDownArrowBlinkCnt2 EQU $FF8C

hSpriteDataOffset EQU $FF8B
hSpriteIndex      EQU $FF8C

hMapStride EQU $FF8B
hMapWidth  EQU $FF8C

hNorthSouthConnectionStripWidth EQU $FF8B
hNorthSouthConnectedMapWidth    EQU $FF8C

; DisplayTextID's argument
hSpriteIndexOrTextID EQU $FF8C

hPartyMonIndex EQU $FF8C

; the total number of tiles being shifted each time the pic slides by one tile
hSlidingRegionSize EQU $FF8C

; 2 bytes
hEnemySpeed EQU $FF8D

hVRAMSlot EQU $FF8D

hFourTileSpriteCount EQU $FF8E

; -1 = left
;  0 = right
hSlideDirection EQU $FF8D

hSpriteFacingDirection EQU $FF8D

hSpriteMovementByte2 EQU $FF8D

hSpriteImageIndex EQU $FF8D

hLoadSpriteTemp1 EQU $FF8D
hLoadSpriteTemp2 EQU $FF8E

hHalveItemPrices EQU $FF8E

hSpriteOffset2 EQU $FF8F

hOAMBufferOffset EQU $FF90

hSpriteScreenX EQU $FF91
hSpriteScreenY EQU $FF92

hTilePlayerStandingOn EQU $FF93

hSpritePriority EQU $FF94

; 2 bytes
hSignCoordPointer EQU $FF95

hNPCMovementDirections2Index EQU $FF95

; CalcPositionOfPlayerRelativeToNPC
hNPCSpriteOffset EQU $FF95

; temp value used when swapping bytes
hSwapTemp EQU $FF95

hExperience EQU $FF96 ; 3 bytes, big endian

; Multiplication and division variables are meant
; to overlap for back-to-back usage. Big endian.

hMultiplicand EQU $FF96 ; 3 bytes
hMultiplier   EQU $FF99 ; 1 byte
hProduct      EQU $FF95 ; 4 bytes

hDividend     EQU $FF95 ; 4 bytes
hDivisor      EQU $FF99 ; 1 byte
hQuotient     EQU $FF95 ; 4 bytes
hRemainder    EQU $FF99 ; 1 byte

hDivideBuffer EQU $FF9A

hMultiplyBuffer EQU $FF9B

; PrintNumber (big endian).
hPastLeadingZeroes EQU $FF95 ; last char printed
hNumToPrint        EQU $FF96 ; 3 bytes
hPowerOfTen        EQU $FF99 ; 3 bytes
hSavedNumToPrint   EQU $FF9C ; 3 bytes

; distance in steps between NPC and player
hNPCPlayerYDistance EQU $FF95
hNPCPlayerXDistance EQU $FF96

hFindPathNumSteps EQU $FF97

; bit 0: set when the end of the path's Y coordinate matches the target's
; bit 1: set when the end of the path's X coordinate matches the target's
; When both bits are set, the end of the path is at the target's position
; (i.e. the path has been found).
hFindPathFlags EQU $FF98

hFindPathYProgress EQU $FF99
hFindPathXProgress EQU $FF9A

; 0 = from player to NPC
; 1 = from NPC to player
hNPCPlayerRelativePosPerspective EQU $FF9B

; bit 0:
; 0 = target is to the south or aligned
; 1 = target is to the north
; bit 1:
; 0 = target is to the east or aligned
; 1 = target is to the west
hNPCPlayerRelativePosFlags EQU $FF9D

; some code zeroes this for no reason when writing a coin amount
hUnusedCoinsByte EQU $FF9F

hMoney EQU $FF9F ; 3-byte BCD number
hCoins EQU $FFA0 ; 2-byte BCD number

hDivideBCDDivisor  EQU $FFA2 ; 3-byte BCD number
hDivideBCDQuotient EQU $FFA2 ; 3-byte BCD number
hDivideBCDBuffer   EQU $FFA5 ; 3-byte BCD number

hSerialReceivedNewData EQU $FFA9

; $01 = using external clock
; $02 = using internal clock
; $ff = establishing connection
hSerialConnectionStatus EQU $FFAA

hSerialIgnoringInitialData EQU $FFAB

hSerialSendData EQU $FFAC

hSerialReceiveData EQU $FFAD

; these values are copied to SCX, SCY, and WY during V-blank
hSCX EQU $FFAE
hSCY EQU $FFAF
hWY  EQU $FFB0

hJoyLast     EQU $FFB1
hJoyReleased EQU $FFB2
hJoyPressed  EQU $FFB3
hJoyHeld     EQU $FFB4
hJoy5        EQU $FFB5
hJoy6        EQU $FFB6
hJoy7        EQU $FFB7

hLoadedROMBank EQU $FFB8

hSavedROMBank EQU $FFB9

; is automatic background transfer during V-blank enabled?
; if nonzero, yes
; if zero, no
hAutoBGTransferEnabled EQU $FFBA

TRANSFERTOP    EQU 0
TRANSFERMIDDLE EQU 1
TRANSFERBOTTOM EQU 2

; 00 = top third of background
; 01 = middle third of background
; 02 = bottom third of background
hAutoBGTransferPortion EQU $FFBB

; the destination address of the automatic background transfer
hAutoBGTransferDest EQU $FFBC ; 2 bytes

; temporary storage for stack pointer during memory transfers that use pop
; to increase speed
hSPTemp EQU $FFBF ; 2 bytes

; source address for VBlankCopyBgMap function
; the first byte doubles as the byte that enabled the transfer.
; if it is 0, the transfer is disabled
; if it is not 0, the transfer is enabled
; this means that XX00 is not a valid source address
hVBCopyBGSrc EQU $FFC1 ; 2 bytes

; destination address for VBlankCopyBgMap function
hVBCopyBGDest EQU $FFC3 ; 2 bytes

; number of rows for VBlankCopyBgMap to copy
hVBCopyBGNumRows EQU $FFC5

; size of VBlankCopy transfer in 16-byte units
hVBCopySize EQU $FFC6

; source address for VBlankCopy function
hVBCopySrc EQU $FFC7

; destination address for VBlankCopy function
hVBCopyDest EQU $FFC9

; size of source data for VBlankCopyDouble in 8-byte units
hVBCopyDoubleSize EQU $FFCB

; source address for VBlankCopyDouble function
hVBCopyDoubleSrc EQU $FFCC

; destination address for VBlankCopyDouble function
hVBCopyDoubleDest EQU $FFCE

; controls whether a row or column of 2x2 tile blocks is redrawn in V-blank
; 00 = no redraw
; 01 = redraw column
; 02 = redraw row
hRedrawRowOrColumnMode EQU $FFD0

REDRAW_COL EQU 1
REDRAW_ROW EQU 2

hRedrawRowOrColumnDest EQU $FFD1

hRandomAdd EQU $FFD3
hRandomSub EQU $FFD4

hFrameCounter EQU $FFD5 ; decremented every V-blank (used for delays)

; V-blank sets this to 0 each time it runs.
; So, by setting it to a nonzero value and waiting for it to become 0 again,
; you can detect that the V-blank handler has run since then.
hVBlankOccurred EQU $FFD6

; 00 = indoor
; 01 = cave
; 02 = outdoor
; this is often set to 00 in order to turn off water and flower BG tile animations
hTilesetType EQU $FFD7

hMovingBGTilesCounter1 EQU $FFD8

hCurrentSpriteOffset EQU $FFDA ; multiple of $10

hItemCounter EQU $FFDB

hGymGateIndex EQU $FFDB

hGymTrashCanRandNumMask EQU $FFDB

hDexRatingNumMonsSeen  EQU $FFDB
hDexRatingNumMonsOwned EQU $FFDC

; $00 = bag full
; $01 = got item
; $80 = didn't meet required number of owned mons
; $FF = player cancelled
hOaksAideResult       EQU $FFDB

hOaksAideRequirement  EQU $FFDB ; required number of owned mons
hOaksAideRewardItem   EQU $FFDC
hOaksAideNumMonsOwned EQU $FFDD

hItemToRemoveID    EQU $FFDB
hItemToRemoveIndex EQU $FFDC

hVendingMachineItem  EQU $FFDB
hVendingMachinePrice EQU $FFDC ; 3-byte BCD number

; the first tile ID in a sequence of tile IDs that increase by 1 each step
hStartTileID EQU $FFE1

hNewPartyLength EQU $FFE4

hDividend2 EQU $FFE5
hDivisor2  EQU $FFE6
hQuotient2 EQU $FFE7

hSpriteVRAMSlotAndFacing EQU $FFE9

hCoordsInFrontOfPlayerMatch EQU $FFEA

hSpriteAnimFrameCounter EQU $FFEA

hWhoseTurn EQU $FFF3 ; 0 on player’s turn, 1 on enemy’s turn

; bit 0: draw HP fraction to the right of bar instead of below (for party menu)
; bit 1: menu is double spaced
hFlags_0xFFF6 EQU $FFF6

hFieldMoveMonMenuTopMenuItemX EQU $FFF7

hDisableJoypadPolling EQU $FFF9

hJoyInput EQU $FFF8

