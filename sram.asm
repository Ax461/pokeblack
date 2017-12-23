SECTION "Sprite Buffers", SRAM

sSpriteBuffer0:: ds SPRITEBUFFERSIZE ; a000
sSpriteBuffer1:: ds SPRITEBUFFERSIZE ; a188
sSpriteBuffer2:: ds SPRITEBUFFERSIZE ; a310

	ds $100

sHallOfFame:: ds HOF_TEAM * HOF_TEAM_CAPACITY ; a598


SECTION "Save Data", SRAM
sPlayerName::  ds NAME_LENGTH ; a000
sMainData::    ds wMainDataEnd   - wMainDataStart ; a00b
sSpriteData::  ds wSpriteDataEnd - wSpriteDataStart ; a794
sPartyData::   ds wPartyDataEnd  - wPartyDataStart ; a994
sCurBoxData::  ds wBoxDataEnd    - wBoxDataStart ; ab28
sTilesetType:: ds 1 ; af8a
sMainDataCheckSum:: ds 1 ; af8b

sKilledMons::  ds 2001 ; af8c
sKilledMonsEnd::

sKilledTrainers:: ds 401 ; b75d


SECTION "Saved Boxes 1", SRAM

sBox1:: ds wBoxDataEnd - wBoxDataStart ; a000
sBox2:: ds wBoxDataEnd - wBoxDataStart ; a462
sBox3:: ds wBoxDataEnd - wBoxDataStart ; a8c4
sBox4:: ds wBoxDataEnd - wBoxDataStart ; ad26
sBox5:: ds wBoxDataEnd - wBoxDataStart ; b188
sBox6:: ds wBoxDataEnd - wBoxDataStart ; b5ea
sBank2AllBoxesChecksum:: ds 1 ; ba4c
sBank2IndividualBoxChecksums:: ds 6 ; ba4d


SECTION "Saved Boxes 2", SRAM

sBox7::  ds wBoxDataEnd - wBoxDataStart ; a000
sBox8::  ds wBoxDataEnd - wBoxDataStart ; a462
sBox9::  ds wBoxDataEnd - wBoxDataStart ; a8c4
sBox10:: ds wBoxDataEnd - wBoxDataStart ; ad26
sBox11:: ds wBoxDataEnd - wBoxDataStart ; b188
sBox12:: ds wBoxDataEnd - wBoxDataStart ; b5ea
sBank3AllBoxesChecksum:: ds 1 ; ba4c
sBank3IndividualBoxChecksums:: ds 6 ; ba4d
