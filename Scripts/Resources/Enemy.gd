extends Resource
class_name Enemy

export (String) var Name

# Graphismes
export (Texture) var BattleSprite

# Stats primaires
export (int, 1, 100) var StatFor = 50
export (int, 1, 100) var StatInt = 50
export (int, 1, 100) var StatDex = 50

# Stats secondaires
export (int, 1, 10000) var StatHP = 100
export (int, 1, 10000) var StatMP = 100
export (int, 1, 100) var StatInit = 5

var HP: int = StatHP
var MP: int = StatMP


func _ready():
	pass
