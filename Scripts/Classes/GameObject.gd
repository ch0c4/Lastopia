extends StaticBody2D
class_name GameObject

# Liste des interactions possibles
enum INTERACTIONS { DIALOG, BATTLE, SAVE, SHOP }

export (String) var Name  # Nom de l'objet

export (INTERACTIONS) var InteractType  # Type d'interaction
export (Resource) var InteractResource  # Resource correspondant au type

var battleground: PackedScene = preload("res://Scenes/CoreScenes/Battleground.tscn")


func _ready() -> void:
	checkType()


func checkType() -> void:
	var type_error: bool = true
	if (
		(InteractType == 0 && InteractResource is Dialogue)
		|| (InteractType == 1 && InteractResource is Battle)
	):
		type_error = false

	# Retourner une erreur si le type ne corresponds pas au type
	assert(! type_error, "La resource ne coresponds pas au type.")


# Lancement de l'interaction en fonction du type
func interact() -> void:
	match InteractType:
		0:  # Dialogue
			Globals.DialogueBox.start(InteractResource)
		1:  # Combat
			var bg = battleground.instance()
			bg.start(InteractResource)
			Globals.GameScene.add_child(bg)
		2:  # Save
			pass
		3:  # Shop
			pass
