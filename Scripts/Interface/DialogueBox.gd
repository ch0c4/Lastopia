extends Control

var dialog: PoolStringArray
var dialog_index: int = 0
var dialog_finished: bool = false

onready var dialog_text = $Dialog
onready var dialog_arrow = $Arrow
onready var dialog_tween = $Tween


func _ready():
	Globals.DialogueBox = self


# Debut d'un dialogue
func start(new_dialog: Dialogue) -> void:
	dialog_index = 0
	dialog = new_dialog.DialogContent
	Globals.is_dialogue = true
	load_dialog()
	visible = true


func _process(_delta) -> void:
	dialog_arrow.visible = dialog_finished
	if Input.is_action_just_pressed("ui_interact"):
		if dialog_finished:
			load_dialog()
		else:
			finish_dialog()


# Charger le prochain dialogue
func load_dialog() -> void:
	if dialog_index < dialog.size():
		dialog_finished = false
		dialog_text.bbcode_text = tr(dialog[dialog_index])
		dialog_text.percent_visible = 0
		dialog_tween.interpolate_property(
			dialog_text, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		dialog_tween.start()
	else:  # Si c'est le dernier dialogue
		Globals.is_dialogue = false
		visible = false
	dialog_index += 1


# Afficher l'integralite du dialogue en cours
func finish_dialog() -> void:
	dialog_tween.stop(dialog_text)
	dialog_text.percent_visible = 1
	dialog_finished = true


# Lorsque le Tween est termine
func on_tween_completed(_object, _key):
	dialog_finished = true
