extends GridMap

#Local Variables
var spawn_point:Vector3 = Vector3()

#Player Variables
onready var S_player = preload("res://Player/S_player.tscn") as PackedScene
var S_player_instance: KinematicBody

func _ready():
	spawn_point = SI_spawn_point.find_spawn_point(self)
	
	#Load Player
	S_player_instance = S_player.instance()
	
	#Inject PLAYER with information
	S_player_instance.spawn_point = spawn_point
	
	if(S_player_instance):
		add_child(S_player_instance)
	
func is_cell_vacant(this_grid_pos=Vector3(), direction=Vector3()) -> Vector3:
	var target_grid_pos = world_to_map(this_grid_pos) + direction
	var new_position = map_to_world(target_grid_pos.x, target_grid_pos.y, target_grid_pos.z)
	return new_position