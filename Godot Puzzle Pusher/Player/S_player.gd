extends Spatial

var spawn_point:Vector3 = Vector3() setget set_spawn_point

func _ready():
	pass

func set_spawn_point(spawn: Vector3):
	spawn_point = spawn
	translation = spawn_point
	print(spawn)