extends Node

enum GAMEMODE { NORMAL, BATTLE }
var inventory_categories = ["weapon", "armor", "consommable", "quest"]  # Liste des categories de l'inventaire

# Informations Jeu
var GameMode = GAMEMODE.NORMAL

# Informations Equipement / Equipe
var Team: Array = [
	preload("res://Resources/Characters/seth.tres"),
	preload("res://Resources/Characters/nyla.tres"),
	preload("res://Resources/Characters/jyna.tres"),
	preload("res://Resources/Characters/kyros.tres")
]  # Membres dans l'equipe actuel
var Inventory: Array  # Inventaire du l'equipe

# Raccourcis nodes
var GameScene: Node2D  # Scene de jeu
var Player: KinematicBody2D  # Joueur
var UserInterface: CanvasLayer  # Interface
var DialogueBox: Control  # Boite de dialogue

var is_dialogue: bool = false  # Si en mode dialogue


# Retourne la liste des objets dans l'inventaire en fonction de la categorie demande
func getInventoryCategory(category: String) -> Array:
	var newInv: Array = []
	for item in Inventory:
		if item.inventory_categories[item.Type] == category:
			newInv.append(item)
	print(category + ": ", newInv)
	return newInv
