extends GridMap

var spawn_point:Vector3 = Vector3()

#Player Variables
onready var S_player = preload("res://Player/S_player.tscn") as PackedScene
var S_player_instance: Spatial

func _ready():
	spawn_point = SI_spawn_point.find_spawn_point(self)
	
	#Load Player
	S_player_instance = S_player.instance()
	
	#Inject PLAYER with information
	S_player_instance.spawn_point = spawn_point
	
	S_player_instance.grid_map_coords = get_used_cells()
	
	if(S_player_instance):
		add_child(S_player_instance)
	