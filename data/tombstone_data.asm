TombstoneTileBlocks:
	db $00
	db $8A ; CERULEAN_CITY
	db $84 ; ROUTE_3
	db $80
	db $83
	db $81
	db $82
	db $83
	db $85
	db $86
	db $81 ; ROUTE_4
	db $8D ; ROUTE_6
	db $87
	db $8B
	db $81
	db $82
	db $86
	db $A3 ; ROUTE_8
	db $A2
	db $99
	db $96
	db $A4
	db $A5
	db $99
	db $96
	db $82
	db $9C ; ROUTE_9
	db $9D
	db $87
	db $9E
	db $8D
	db $81
	db $80
	db $81
	db $9E
	db $A0 ; ROUTE_10
	db $87
	db $80
	db $9F
	db $A1
	db $8E
	db $98 ; ROUTE_11
	db $8B
	db $8C
	db $9A
	db $99
	db $8C
	db $8C
	db $8C
	db $9B
	db $97
	db $87 ; ROUTE_24
	db $86
	db $89
	db $88
	db $89
	db $88
	db $89
	db $95 ; ROUTE_25
	db $96
	db $95
	db $92
	db $93
	db $94
	db $80
	db $81
	db $91
	db $80 ; VIRIDIAN_FOREST
	db $80
	db $81
	db $74 ; PEWTER_GYM
	db $75
	db $81 ; MT_MOON_1
	db $80
	db $80
	db $82
	db $82
	db $81
	db $82
	db $85 ; MT_MOON_3
	db $84
	db $84
	db $83
	db $83
	db $76 ; CERULEAN_GYM
	db $77
	db $16
	db $83 ; ROCK_TUNNEL_1
	db $81
	db $83
	db $81
	db $83
	db $80
	db $80
	db $7A ; VERMILION_GYM
	db $79
	db $79
	db $78
	db $3E ; SS_ANNE_5
	db $3E
	db $3F ; SS_ANNE_8
	db $40
	db $40
	db $41
	db $42 ; SS_ANNE_9
	db $43
	db $47
	db $44
	db $3F ; SS_ANNE_10
	db $44
	db $45
	db $46
	db $42
	db $47
	db $80 ; CELADON_GYM
	db $7C
	db $7B
	db $7D
	db $7D
	db $7F
	db $7E
	db $81
	db $4F ; GAME_CORNER
	db $17 ; POKEMONTOWER_3
	db $4E
	db $69
	db $4E ; POKEMONTOWER_4
	db $50
	db $51
	db $13 ; POKEMONTOWER_5
	db $5D
	db $4D
	db $53
	db $67 ; POKEMONTOWER_6
	db $6A
	db $59
	db $57 ; POKEMONTOWER_7
	db $58
	db $57
	db $82 ; ROCKET_HIDEOUT_1
	db $80
	db $83
	db $86
	db $85
	db $80 ; ROCKET_HIDEOUT_2
	db $80 ; ROCKET_HIDEOUT_3
	db $84
	db $81 ; ROCKET_HIDEOUT_4
	db $80
	db $81
	db $83 ; ROCK_TUNNEL_2
	db $80
	db $83
	db $82
	db $80
	db $80
	db $83
	db $80

; \1 map
; \2 1st trainer ID
; \3 2nd trainer ID
; \4 original tile
; \5 new tile
double_tombstone: MACRO
	db \1
	db \4
	dw \2
	dw \3
	db \5
ENDM

DoubleTombstoneTileBlocks:
	double_tombstone ROUTE_6, KT_ROUTE_6_TRAINER_0, KT_ROUTE_6_TRAINER_1, $87, $8F
	double_tombstone ROUTE_6, KT_ROUTE_6_TRAINER_3, KT_ROUTE_6_TRAINER_4, $82, $90
	double_tombstone ROUTE_8, KT_ROUTE_8_TRAINER_4, KT_ROUTE_8_TRAINER_5, $A5, $A6
	double_tombstone CELADON_GYM, KT_CELADON_GYM_LEADER, KT_CELADON_GYM_TRAINER_6, $81, $82

	db $ff
