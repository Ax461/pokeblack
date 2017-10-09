TombstoneTileBlocks:
	db $00
	db $9D ; CERULEAN_CITY
	db $86 ; ROUTE_3
	db $80
	db $8B
	db $82
	db $81
	db $8B
	db $87
	db $A6
	db $82 ; ROUTE_4
	db $96 ; ROUTE_6
	db $95
	db $A8
	db $82
	db $81
	db $A6
	db $9B ; ROUTE_8
	db $91
	db $AA
	db $83
	db $AC
	db $AE
	db $AA
	db $83
	db $81
	db $98 ; ROUTE_9
	db $99
	db $95
	db $93
	db $96
	db $82
	db $80
	db $82
	db $93
	db $B0 ; ROUTE_10
	db $95
	db $80
	db $9E
	db $B1
	db $94
	db $A9 ; ROUTE_11
	db $A8
	db $A7
	db $AB
	db $AA
	db $A7
	db $A7
	db $A7
	db $AD
	db $A5
	db $A3 ; ROUTE_12
	db $A2
	db $A1
	db $93
	db $A0
	db $A1
	db $8C
	db $94 ; ROUTE_16
	db $96
	db $94
	db $95
	db $80
	db $94
	db $AD ; ROUTE_17
	db $90
	db $8F
	db $90
	db $AA
	db $90
	db $AA
	db $AA
	db $90
	db $93
	db $8D ; ROUTE_18
	db $A8
	db $8E
	db $95 ; ROUTE_24
	db $A6
	db $A2
	db $A0
	db $A2
	db $A0
	db $A2
	db $8A ; ROUTE_25
	db $83
	db $8A
	db $88
	db $92
	db $90
	db $80
	db $82
	db $89
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
	db $83 ; FIGHTING_DOJO
	db $7B
	db $7B
	db $83
	db $83
	db $81 ; SAFFRON_GYM
	db $83
	db $92
	db $92
	db $92
	db $92
	db $92
	db $92
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
	db $81 ; SILPH_CO_2F
	db $87
	db $87
	db $87
	db $89 ; SILPH_CO_3F
	db $88
	db $81 ; SILPH_CO_4F
	db $80
	db $8A
	db $84 ; SILPH_CO_5F
	db $87
	db $80
	db $8B
	db $88 ; SILPH_C0_6F
	db $81
	db $8C
	db $8E ; SILPH_CO_7F
	db $8D
	db $80
	db $81
	db $81 ; SILPH_CO_8F
	db $80
	db $87
	db $83 ; ROCK_TUNNEL_2
	db $80
	db $83
	db $82
	db $80
	db $80
	db $83
	db $80
	db $8F ; SILPH_CO_9F
	db $88
	db $90
	db $91 ; SILPH_CO_10F
	db $80
	db $3B ; SILPH_CO_11F
	db $3A

; \1 map
; \2 1st trainer index
; \3 2nd trainer index
; \4 sprite ID
; \5 new tile
double_tombstone: MACRO
	db \1
	db \4
	dw \2
	dw \3
	db \5
ENDM

DoubleTombstoneTileBlocks:
	double_tombstone ROUTE_6, KT_ROUTE_6_TRAINER_0, KT_ROUTE_6_TRAINER_1, $2, $97
	double_tombstone ROUTE_6, KT_ROUTE_6_TRAINER_3, KT_ROUTE_6_TRAINER_4, $5, $85
	double_tombstone ROUTE_8, KT_ROUTE_8_TRAINER_4, KT_ROUTE_8_TRAINER_5, $6, $AF
	double_tombstone CELADON_GYM, KT_CELADON_GYM_LEADER, KT_CELADON_GYM_TRAINER_6, $8, $82

	db $ff
