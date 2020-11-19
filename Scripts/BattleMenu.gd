extends CanvasLayer

onready var char1 = get_node("Chars/Char1")
onready var char2 = get_node("Chars/Char2")
onready var char3 = get_node("Chars/Char3")

onready var enemiesList = get_node("Enemies/EnemiesContainer/EnemiesList")
onready var actionsList = get_node("Menu/ActionContainer/ActionList")
onready var selectionsList = get_node("Selection/SelectionContainer/SelectionList")

onready var Chars: Array = [char1, char2, char3]  # Menus d'allies

var button: PackedScene = preload("res://Scenes/CoreScenes/BattlegroundButton.tscn")

var BattleTeam: Array  # Allies en combat


# Defini les allies dans le menu
func setAllies() -> void:
	for i in len(Chars):
		if BattleTeam[i] != null:
			var charPanel = Chars[i]
			var charTeam = BattleTeam[i]
			charPanel.visible = true
			charPanel.get_node("Name").text = str(charTeam.Name)
			charPanel.get_node("LifeBar").max_value = charTeam.StatHP
			UpdateHP(charPanel, charTeam.HP)
			UpdateMP(charPanel, charTeam.MP)


func setEnemies(enemies: Array) -> void:
	delChilds(enemiesList)
	var count := 1
	for e in enemies:
		createBtn(enemiesList, e.Name + " " + str(count), e.Name + "_" + str(count))
		count += 1


# Met a jour les points de vie
func UpdateHP(node: Node, hp: int) -> void:
	node.get_node("LifeBar").value = hp
	node.get_node("HP").text = "HP: " + str(hp) + " / 100"


# Met a jour les points de mana
func UpdateMP(node: Node, mp: int) -> void:
	node.get_node("MP").text = "MP: " + str(mp) + " / 100"


# Creer un boutton dans la node selectionne avec les informations donnees
func createBtn(parent: Node, text: String, name: String) -> void:
	var b = button.instance()
	b.name = name
	b.text = text
	parent.add_child(b)


# Supprime tous les enfants d'un parent
func delChilds(parent: Node) -> void:
	for childs in parent.get_children():
		childs.queue_free()
