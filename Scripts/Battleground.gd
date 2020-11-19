extends Node2D

# Allies et enemies
export (Array, Resource) var Team
export (Array, Resource) var Enemies

# Sprites allies
onready var ally1: Sprite = get_node("Allies/Sprite1")
onready var ally2: Sprite = get_node("Allies/Sprite2")
onready var ally3: Sprite = get_node("Allies/Sprite3")

# Sprites enemies
onready var enemy1: Sprite = get_node("Enemies/Sprite1")
onready var enemy2: Sprite = get_node("Enemies/Sprite2")
onready var enemy3: Sprite = get_node("Enemies/Sprite3")
onready var enemy4: Sprite = get_node("Enemies/Sprite4")
onready var enemy5: Sprite = get_node("Enemies/Sprite5")
onready var enemy6: Sprite = get_node("Enemies/Sprite6")

# Menu de combat
onready var Menu: CanvasLayer = get_node("BattleMenu")

# Placement pour les sprites
onready var allies_placement: Array = [ally2, ally1, ally3]
onready var enemies_placement: Array = [enemy5, enemy4, enemy6, enemy2, enemy1, enemy3]

var battle: Battle  # Informations sur le combat en cours
var turnOrder: Array  # Ordre de jeu


# Debut et lancement du mode combat
func start(new_battle: Battle) -> void:
	battle = new_battle
	Globals.GameMode = Globals.GAMEMODE.BATTLE
	Team = []
	for member in Globals.Team:
		if battle.AutorisedCharacters.find(member.Name):
			Team.append(member)
	Enemies = battle.Enemies
	SetTurnOrder()


func _ready() -> void:
	SetAllies()
	SetEnemies()

	# TODO: Retirer ca
	randomize()
	for member in Team:
		member.HP = randi() % member.StatHP
		member.MP = randi() % member.StatMP

	Menu.setAllies()


# Definition et configuration des allies
func SetAllies() -> void:
	OnlyAutorised()
	DefineSprite(Team, allies_placement, 3)


# Definition des enemies
func SetEnemies() -> void:
	DefineSprite(Enemies, enemies_placement, 6)


# Filtre des allies autorise
func OnlyAutorised() -> void:
	var team = Team.duplicate()
	Team = []
	for member in team:
		if member in battle.AutorisedCharacters:
			Team.append(member)
	Menu.BattleTeam = Team


# Defini les sprites
func DefineSprite(elements: Array, places: Array, limit: int):
	for i in len(elements):
		if i < limit && elements[i] != null:
			places[i].texture = elements[i].BattleSprite


# Calcule et generation du turn order
func SetTurnOrder() -> void:
	turnOrder = []
	for e in Team:
		turnOrder.append(e)
	for e in Enemies:
		turnOrder.append(e)

	turnOrder.sort_custom(self, "initOrder")


# Ordonne les elements par initiattive
func initOrder(a, b):
	return b.StatInit < a.StatInit
