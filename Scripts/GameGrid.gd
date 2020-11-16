# Grille de jeu, elements / enfants dans l'Array "grid"
extends TileMap

enum { EMPTY, PLAYER, OBSTACLE, COLLECTIBLE }

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var grid_size = Vector2(cell_quadrant_size, cell_quadrant_size)

var grid = []
onready var Obstacle = preload("res://Scenes/WorldScenes/Obstacle.tscn")
onready var Player = preload("res://Scenes/WorldScenes/Player.tscn")
const PLAYER_STARTPOS = Vector2(4, 4)


func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for _y in range(grid_size.y):
			grid[x].append(EMPTY)

	# Player
	var new_player = Player.instance()
	new_player.position = map_to_world(PLAYER_STARTPOS) + half_tile_size
	grid[PLAYER_STARTPOS.x][PLAYER_STARTPOS.y] = PLAYER
	add_child(new_player)

	# Obstacles
	var positions = []
	for _n in range(5):
		var placed = false
		while not placed:
			var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
			if not grid[grid_pos.x][grid_pos.y]:
				if not grid_pos in positions:
					positions.append(grid_pos)
					placed = true

	for pos in positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.position = map_to_world(pos) + half_tile_size
		grid[pos.x][pos.y] = OBSTACLE
		add_child(new_obstacle)


# Verifie si la cellule de la direction est libre
func is_cell_vacant(this_grid_pos = Vector2(), direction = Vector2()):
	var target_grid_pos = world_to_map(this_grid_pos) + direction

	# Verifie si la cellule cible se trouve dans la grille
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# Si a l'interieur de la grille, le retour est true si la cellule cible est vide
			return true if grid[target_grid_pos.x][target_grid_pos.y] == EMPTY else false
	return false


# Retirez le noeud de la cellule actuelle, ajoutez-le a la nouvelle cellule,,
# renvoie la nouvelle position de cible world
func update_child_pos(this_world_pos, direction, type):
	var this_grid_pos = world_to_map(this_world_pos)
	var new_grid_pos = this_grid_pos + direction

	# supprimer le joueur de l'emplacement actuel de la grille
	grid[this_grid_pos.x][this_grid_pos.y] = EMPTY

	# placer le joueur sur un nouvel emplacement de la grille
	grid[new_grid_pos.x][new_grid_pos.y] = type

	var new_world_pos = map_to_world(new_grid_pos) + half_tile_size
	return new_world_pos
