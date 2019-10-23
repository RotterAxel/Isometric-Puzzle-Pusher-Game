extends Node

#Level Variables
export var level_scene: PackedScene
var S_level_instance

#Player Variables
onready var S_player = preload("res://Player/S_player.tscn") as PackedScene
var S_player_instance: Spatial

func _ready():
	#Load Level 
	S_level_instance = level_scene.instance()
	
	if(S_level_instance):
		add_child(S_level_instance)
	
	#Load Player
	S_player_instance = S_player.instance()
	
	if(S_player_instance):
		add_child(S_player_instance)
	
	#DEBUGGER: Print the entire Player Transform to the Spawn Point
	#print(S_player_instance.transform.translated(S_level1_instance.spawn_point))
	
	#Inject PLAYER with information
	S_player_instance.spawn_point = S_level_instance.spawn_point
	
	S_player_instance.grid_map_coords = S_level_instance.GRID_MAP.get_used_cells()