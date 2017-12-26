db DEX_GHOST ; pokedex id
db 80 ; base hp
db 80 ; base attack
db 80 ; base defense
db 80 ; base speed
db 80 ; base special
db UNKNOWN ; species type 1
db UNKNOWN ; species type 2
db 0 ; catch rate
db 0 ; base exp yield
INCBIN "pic/mon/ghost.pic",0,1 ; 66, sprite dimensions
dw GhostPicFront
dw GhostPicBack
; attacks known at lvl 0
db CURSE
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
