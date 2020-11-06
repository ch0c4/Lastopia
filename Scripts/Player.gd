extends KinematicBody2D

export var move_speed: float = 160  #Vitesse de base

var velocity: Vector2 = Vector2.ZERO  #Velocite calcule
var direction: Vector2 = Vector2.ZERO  #Direction en fonction des inputs


func _ready():
	pass


func _process(delta):
	Inputs()
	Movements(delta)


# Gestion des inputs du joueur
func Inputs():
	# Recuperation des inputs
	var left: int = Input.is_action_pressed("ui_left")
	var right: int = Input.is_action_pressed("ui_right")
	var up: int = Input.is_action_pressed("ui_up")
	var down: int = Input.is_action_pressed("ui_down")

	# Calcule de la direction
	direction.x = right - left
	direction.y = down - up


# Gestion des mouvements du joueur
func Movements(delta):
	velocity = move_and_slide((direction * move_speed) * (delta * 60))
