extends Node

enum GAMEMODE { NORMAL, BATTLE }

# Informations Jeu
var GameMode = GAMEMODE.NORMAL

# Informations Equipement / Equipe
var Team: Array = [
	preload("res://Resources/Characters/seth.tres"),
	preload("res://Resources/Characters/nyla.tres"),
	preload("res://Resources/Characters/jyna.tres"),
	preload("res://Resources/Characters/kyros.tres")
]  # Membres dans l'equipe actuele

# Raccourcis nodes
var GameScene: Node2D  # Scene de jeu
var Player: KinematicBody2D  # Joueur
var UserInterface: CanvasLayer  # Interface
var DialogueBox: Control  # Boite de dialogue

var is_dialogue: bool = false  # Si en mode dialogue
