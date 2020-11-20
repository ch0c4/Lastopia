extends Resource
class_name Stuff

enum EQUIPEMENT_TYPE { WEAPON, ARMOR, CONSOMMABLE, QUEST }
enum WEAPON_TYPE { NULL, DAGGER, SWORD, AXE, BOW }
enum ARMOR_PART { NULL, HELMET, CHEST, PANTS, GLOVES, ACCESORIES }

var inventory_categories = ["weapon", "armor", "consommable", "quest"]  # Liste des categories de l'inventaire

export (String) var Name  # Nom de l'item
export (String, MULTILINE) var Description

export (EQUIPEMENT_TYPE) var Type  # Type d'objet
export (WEAPON_TYPE) var WeaponType  # Null si pas une arme
export (ARMOR_PART) var ArmurePart  # Null si pas une armure

export (int, FLAGS, "Warrior", "Ranger", "Enginer") var Classes  # Classe autorise pour equipement

export (int, 1, 100) var StatFor = 50  # FORCE
export (int, 1, 100) var StatInt = 50  # INTELLIGENCE
export (int, 1, 100) var StatDex = 50  # DEXTERITE

export (int, 1, 999) var Amount = 1  # Quantite
