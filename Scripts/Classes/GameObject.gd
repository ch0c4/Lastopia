extends StaticBody2D
class_name GameObject

# Liste des interactions possibles
enum INTERACTIONS { DIALOG, SAVE_MENU, SHOP }

export (String) var Name  # Nom de l'objet

export (INTERACTIONS) var InteractType  # Type d'interaction
export (Resource) var InteractResource  # Resource correspondant au type


func _ready() -> void:
	checkType()


func checkType() -> void:
	var type_error: bool = true
	if InteractType == 0 && InteractResource is Dialogue:
		type_error = false

	# Retourner une erreur si le type ne corresponds pas
	assert(! type_error, "La resource ne coresponds pas au type.")


# Lancement de l'interaction en fonction du type
func interact() -> void:
	match InteractType:
		0:
			Globals.DialogueBox.start(InteractResource.DialogContent)
