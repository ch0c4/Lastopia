extends CanvasLayer

onready var char1 = get_node("Container/Group/Char1")
onready var char2 = get_node("Container/Group/Char2")
onready var char3 = get_node("Container/Group/Char3")

onready var Chars: Array = [char1, char2, char3]  # Menus d'allies

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


# Met a jour les points de vie
func UpdateHP(node: Panel, hp: int) -> void:
	node.get_node("LifeBar").value = hp
	node.get_node("HP").text = "HP: " + str(hp) + " / 100"


# Met a jour les points de mana
func UpdateMP(node: Panel, mp: int) -> void:
	node.get_node("MP").text = "MP: " + str(mp) + " / 100"
