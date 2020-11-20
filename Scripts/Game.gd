extends Node2D

# TODO: Temporairement le temps de tests
export (Array, Resource) var Inventory


func _ready():
	Globals.GameScene = self
	Globals.Inventory = Inventory
