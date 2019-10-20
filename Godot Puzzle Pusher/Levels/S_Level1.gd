extends "res://Levels/Level.gd"

onready var GRID_MAP = $GridMap as GridMap

func _ready():
	if(GRID_MAP != null):
		spawn_point = singleton_spawn_point.find_spawn_point(GRID_MAP)
	else:
		print(self.name + " no grid map was found")