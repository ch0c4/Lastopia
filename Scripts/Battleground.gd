extends Node2D

export (Array, Resource) var Team
export (Array, Resource) var Enemies

onready var ally1: Sprite = get_node("Allies/Sprite1")
onready var ally2: Sprite = get_node("Allies/Sprite2")
onready var ally3: Sprite = get_node("Allies/Sprite3")

onready var enemy1: Sprite = get_node("Enemies/Sprite1")
onready var enemy2: Sprite = get_node("Enemies/Sprite2")
onready var enemy3: Sprite = get_node("Enemies/Sprite3")
onready var enemy4: Sprite = get_node("Enemies/Sprite4")
onready var enemy5: Sprite = get_node("Enemies/Sprite5")
onready var enemy6: Sprite = get_node("Enemies/Sprite6")

onready var allies_placement: Array = [ally1, ally2, ally3]
onready var enemies_placement: Array = [enemy5, enemy4, enemy6, enemy2, enemy1, enemy3]

var battle: Battle


# Debut et lancement du mode combat
func start(new_battle: Battle) -> void:
	battle = new_battle
	Globals.GameMode = Globals.GAMEMODE.BATTLE
	Team = []
	for member in Globals.Team:
		if battle.AutorisedCharacters.find(member.Name):
			Team.append(member)
	Enemies = battle.Enemies


func _ready() -> void:
	SetAllies()
	SetEnemies()


# Definition et configuration des allies
func SetAllies() -> void:
	onlyAutorised()
	defineSprite(Team, allies_placement, 3)


# Definition des enemies
func SetEnemies() -> void:
	defineSprite(Enemies, enemies_placement, 6)


# Filtre des allies autorise
func onlyAutorised() -> void:
	var team = Team.duplicate()
	Team = []
	for member in team:
		if member in battle.AutorisedCharacters:
			Team.append(member)


# Defini les sprites
func defineSprite(elements: Array, places: Array, limit: int):
	for i in len(elements):
		if i < limit && elements[i] != null:
			print(elements[i].Name)
			places[i].texture = elements[i].BattleSprite
	print("-----------")
