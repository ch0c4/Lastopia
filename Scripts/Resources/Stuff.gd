extends Resource
class_name Stuff

enum EQUIPEMENT_TYPE { WEAPON, ARMOR, CONSOMABLE, QUEST }
enum WEAPON_TYPE { NULL, DAGGER, SWORD, AXE, BOW }
enum ARMOR_PART { NULL, HELMET, CHEST, PANTS, GLOVES, ACCESORIES }

export (String) var Name  # Nom de l'item

export (EQUIPEMENT_TYPE) var Type  # Type d'objet
export (WEAPON_TYPE) var WeaponType  # Null si pas une arme
export (ARMOR_PART) var ArmurePart  # Null si pas une armure

export (int, FLAGS, "Warrior", "Ranger", "Enginer") var Classes  # Classe autorise pour equipement

export (int, 1, 100) var StatFor = 50  # FORCE
export (int, 1, 100) var StatInt = 50  # INTELLIGENCE
export (int, 1, 100) var StatDex = 50  # DEXTERITE
