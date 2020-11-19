extends Resource
class_name Character

enum CLASSES { WARRIOR, RANGER, ENGINER }

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

# Stats dans l'equipe
var HP: int = StatHP
var MP: int = StatMP
