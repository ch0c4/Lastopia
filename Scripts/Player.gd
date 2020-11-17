extends KinematicBody2D

# Stats
var speed: int = 64

# Positions
var last_position: Vector2
var target_position: Vector2
var move_direction: Vector2

# Collisions
onready var ray = get_node("RayCast2D")


func _ready() -> void:
	# Positions de base
	position = position.snapped(Config.TILE_SIZE_V)
	last_position = position
	target_position = position


func _process(delta) -> void:
	# Verification de collision
	if ray.is_colliding():
		position = last_position
		target_position = last_position
	else:
		# Deplacement
		position += speed * move_direction * delta

	# Arret du deplacement
	if position.distance_to(last_position) >= Config.TILE_SIZE - speed * delta:
		position = target_position

	# Debut du deplacement
	if position == target_position:
		get_move_direction()
		last_position = position
		target_position += move_direction * Config.TILE_SIZE


# Set the moving direction from the player inputs
func get_move_direction() -> void:
	# Detection des touches
	var left: int = Input.is_action_pressed("ui_left")
	var right: int = Input.is_action_pressed("ui_right")
	var up: int = Input.is_action_pressed("ui_up")
	var down: int = Input.is_action_pressed("ui_down")

	# Calcule de la direction
	move_direction.x = right - left
	move_direction.y = down - up

	# Verification de la posibilite de se deplacer
	if ! move_possible():
		move_direction = Vector2.ZERO

	# Orientation du raycast
	if move_direction != Vector2.ZERO:
		ray.cast_to = move_direction * Config.TILE_SIZE / 2


# Interdiction de deplacement optionels
func move_possible() -> bool:
	# Liste de conditions, doivent toutes etre false pour se deplacer
	var conditions: Array = [
		Globals.is_dialogue,  # Si un dialogue est ouvert
		move_direction.x != 0 && move_direction.y != 0,  # Limitation a 4 directions
	]
	for condition in conditions:
		if condition:
			return false
	return true
