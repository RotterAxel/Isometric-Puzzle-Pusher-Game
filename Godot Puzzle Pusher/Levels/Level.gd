extends Spatial

var spawn_point:Vector3 = Vector3()

onready var GRID_MAP = $GridMap as GridMap

func _ready():
	if(GRID_MAP != null):
		spawn_point = SI_spawn_point.find_spawn_point(GRID_MAP)
	else:
		print(self.name + " no grid map was found")