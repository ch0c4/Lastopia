extends Control

var dialog: Array = ["Hello world !", "J'adore les patates.", "Pas toi ?"]
var dialog_index: int = 0
var dialog_finished: bool = false

onready var dialog_text = $Dialog
onready var dialog_arrow = $Arrow
onready var dialog_tween = $Tween


func _ready() -> void:
	Globals.is_dialogue = true
	load_dialog()


func _process(_delta):
	dialog_arrow.visible = dialog_finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()


# Charger le prochain dialogue
func load_dialog() -> void:
	if dialog_index < dialog.size():
		dialog_finished = false
		dialog_text.bbcode_text = dialog[dialog_index]
		dialog_text.percent_visible = 0
		dialog_tween.interpolate_property(
			dialog_text, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		dialog_tween.start()
	else:
		Globals.is_dialogue = false
		queue_free()
	dialog_index += 1


func on_tween_completed(_object, _key):
	dialog_finished = true
