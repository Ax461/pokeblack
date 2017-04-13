PrizeDifferentMenuPtrs:
	dw PrizeMenuMon1Entries
	dw PrizeMenuMon1Cost

	dw PrizeMenuMon2Entries
	dw PrizeMenuMon2Cost

	dw PrizeMenuTMsEntries
	dw PrizeMenuTMsCost

NoThanksText:
	db "NO THANKS@"

PrizeMenuMon1Entries:
	db ABRA
	db CLEFAIRY
	db NIDORINA
	db "@"

PrizeMenuMon1Cost:
	coins 180
	coins 500
	coins 1200
	db "@"

PrizeMenuMon2Entries:
	db DRATINI
	db SCYTHER
	db PORYGON
	db "@"

PrizeMenuMon2Cost:
	coins 2800
	coins 5500
	coins 9999
	db "@"

PrizeMenuTMsEntries:
	db TM_23
	db TM_15
	db TM_50
	db "@"

PrizeMenuTMsCost:
	coins 3300
	coins 5500
	coins 7700
	db "@"
