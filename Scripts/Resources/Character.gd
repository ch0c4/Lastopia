extends Resource
class_name Character

var id := randi() % 10000000

enum CLASSES { WARRIOR, RANGER, ENGINER }
enum ACTIONS_LIST { ATTAQUER, TECHNIQUE, OBJET, FUITE }

var actions_list: Array = ["Attaquer", "Technique", "Objet", "Fuite"]

export (String) var Name
export (CLASSES) var Classe

# Graphismes
export (Texture) var MapSprite
export (Texture) var BattleSprite

# Stats primaires
export (int, 1, 100) var StatFor = 50
export (int, 1, 100) var StatInt = 50
export (int, 1, 100) var StatDex = 50

# Stats secondaires
export (int, 1, 10000) var StatHP = 100
export (int, 1, 10000) var StatMP = 100
export (int, 1, 100) var StatInit = 5

# Equipement
export (Resource) var Weapon

export (Resource) var ArmorHelmet
export (Resource) var ArmorChest
export (Resource) var ArmorPants
export (Resource) var ArmorGloves
export (Resource) var ArmorAccesories1
export (Resource) var ArmorAccesories2

# Competences
export (Array, ACTIONS_LIST) var Actions = [
	ACTIONS_LIST.ATTAQUER, ACTIONS_LIST.TECHNIQUE, ACTIONS_LIST.OBJET, ACTIONS_LIST.FUITE
]

# Stats dans l'equipe
var HP: int = StatHP
var MP: int = StatMP
