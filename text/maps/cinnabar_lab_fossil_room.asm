_Lab4Text_75dc6::
	text "Hiya!"

	para "I am important"
	line "doctor!"

	para "I study here rare"
	line "#MON fossils!"

	para "You! Have you a"
	line "fossil for me?"
	prompt

_Lab4Text_75dcb::
	text "No! Is too bad!"
	done

_Lab4Text_75dd0::
	text "I take a little"
	line "time!"

	para "You go for walk a"
	line "little while!"
	done

_Lab4Text_75dd5::
	text "Where were you?"

	para "Your fossil is"
	line "back to life!"

	para "It was @"
	TX_RAM wcf4b
	db $0
	line "like I think!"
	prompt

_Lab4Text_610ae::
	text "Oh! That is"
	line "@"
	TX_RAM wcd6d
	text "!"

	para "It is fossil of"
	line "@"
	TX_RAM wcf4b
	text ", a"
	cont "#MON that is"
	cont "already extinct!"

	para "My Resurrection"
	line "Machine will make"
	cont "that #MON live"
	cont "again!"
	done

_Lab4Text_610b3::
	text "So! You hurry and"
	line "give me that!"

	para $52, " handed"
	line "over @"
	TX_RAM wcd6d
	text "!"
	prompt

_Lab4Text_610b8::
	text "I take a little"
	line "time!"

	para "You go for walk a"
	line "little while!"
	done

_Lab4Text_610bd::
	text "Aiyah! You come"
	line "again!"
	done
