db DEX_GHOST ; pokedex id
db 100 ; base hp
db 100 ; base attack
db 100 ; base defense
db 100 ; base speed
db 100 ; base special
db GHOST_T ; species type 1
db GHOST_T ; species type 2
db 45 ; catch rate
db 64 ; base exp yield
INCBIN "pic/other/ghost.pic",0,1 ; 55, sprite dimensions
dw GhostPicFront
dw GhostPicBack
; attacks known at lvl 0
db POUND
db 0
db 0
db 0
db 0 ; growth rate
; learnset
	tmlearn 0
	tmlearn 0
	tmlearn 0
	tmlearn 0
	tmlearn 0
	tmlearn 0
	tmlearn 0
db 0 ; padding
