extends CanvasLayer

onready var char1 = get_node("Chars/Char1")
onready var char2 = get_node("Chars/Char2")
onready var char3 = get_node("Chars/Char3")

onready var enemiesList = get_node("Enemies/EnemiesContainer/EnemiesList")
onready var actionsList = get_node("Menu/ActionContainer/ActionList")
onready var selectionsList = get_node("Selection/SelectionContainer/SelectionList")
onready var selectionName = get_node("InfosBox/Name")
onready var selectionDescription = get_node("InfosBox/Description")
onready var selectionCost = get_node("InfosBox/Cost")

onready var Chars: Array = [char1, char2, char3]  # Menus d'allies

var button: PackedScene = preload("res://Scenes/CoreScenes/BattlegroundButton.tscn")

var BattleTeam: Array  # Allies en combat

var currentChar: Character  # Personnage en cour
var actions: Array  # Actions du personnage
var currentAction: String  # Action en cours
var selections: Array  # Selections possible du personnage pour l'action en cours
var selectionsElements: Dictionary  # Lien entre la selection et l'element


func _process(_delta) -> void:
	checkBtnActions()
	checkBtnSelections()


# Verification de la selection d'une selection
func checkBtnSelections() -> void:
	for selec in selections:
		if selec.is_hovered():
			if selec.name in selectionsElements:
				var element = selectionsElements[selec.name]
				selectionName.text = element.Name
				selectionDescription.text = element.Description
				if "Cost" in element:
					selectionCost.text = "MP: " + str(element.Cost)
				elif "Amount" in element:
					selectionCost.text = "Amount: " + str(element.Amount)


# Verification de la selection d'une action
func checkBtnActions() -> void:
	for action in actions:
		if action.pressed:
			if currentAction != action.get_meta("id"):
				currentAction = action.get_meta("id")
				updateSelection()
				for a in actions:
					a.disabled = false
				action.disabled = true


# Mise a jour du menu de selection
func updateSelection() -> void:
	match currentAction:
		"Attaquer":
			updateSelectionMenu([])
		"Technique":
			updateSelectionMenu(currentChar.Techniques)
		"Objet":
			updateSelectionMenu(Globals.getInventoryCategory("consommable"), true)
		"Fuite":
			updateSelectionMenu([])
		"":
			updateSelectionMenu([])


# Met a jour le contenu du menu de selection
func updateSelectionMenu(elements: Array, showAmount: bool = false) -> void:
	delChilds(selectionsList)
	selections = []
	for element in elements:
		if showAmount:
			selections.append(
				createBtn(
					selectionsList, element.Name + " (" + str(element.Amount) + ")", element.Name
				)
			)
		else:
			selections.append(createBtn(selectionsList, element.Name, element.Name))
		selectionsElements[element.Name] = element


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


# Defini les enemies dans le menu
func setEnemies(enemies: Array) -> void:
	delChilds(enemiesList)
	var count := 1
	for e in enemies:
		var _b = createBtn(enemiesList, e.Name + " " + str(count), e.Name + "_" + str(count))
		count += 1


# Defini les actions du personnage en cours
func setActions(character: Character) -> void:
	currentChar = character
	currentAction = ""
	updateSelection()
	delChilds(actionsList)
	actions = []
	for action in character.Actions:
		actions.append(
			createBtn(
				actionsList,
				str(character.actions_list[action]),
				str(character.actions_list[action])
			)
		)


# Met a jour les points de vie
func UpdateHP(node: Node, hp: int) -> void:
	node.get_node("LifeBar").value = hp
	node.get_node("HP").text = "HP: " + str(hp) + " / 100"


# Met a jour les points de mana
func UpdateMP(node: Node, mp: int) -> void:
	node.get_node("MP").text = "MP: " + str(mp) + " / 100"


# Creer un bouton dans la node selectionne avec les informations donnees
func createBtn(parent: Node, text: String, name: String) -> Node:
	var b = button.instance()
	b.name = name
	b.set_meta("id", name)
	b.text = text
	parent.add_child(b)
	return b


# Supprime tous les enfants d'un parent
func delChilds(parent: Node) -> void:
	for childs in parent.get_children():
		childs.queue_free()
