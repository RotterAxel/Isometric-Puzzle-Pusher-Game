extends Spatial

var spawn_point:Vector3 = Vector3() setget set_spawn_point
var grid_map_coords: PoolVector3Array = PoolVector3Array() setget set_grid_map_coordinates
var current_position: Vector3 = Vector3()
export var speed: int = 100

func _ready():
	pass

func set_spawn_point(spawn: Vector3):
	spawn_point = spawn
	translation = spawn_point
	current_position = spawn_point
	print(spawn_point)

func set_grid_map_coordinates(coords: PoolVector3Array):
	grid_map_coords = coords

func _process(delta):
	var destination: Vector3
	if Input.is_action_just_pressed("ui_up"):
		current_position.x +=1
	if Input.is_action_just_pressed("ui_down"):
		current_position.x -=1
	if Input.is_action_just_pressed("ui_left"):
		current_position.z -=1
	if Input.is_action_just_pressed("ui_right"):
		current_position.z +=1
	
	translation = current_position

