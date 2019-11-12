extends Node

#Level Variables
export var level_scene: PackedScene
var S_level_instance

#Player Variables
onready var S_player = preload("res://Player/S_player.tscn") as PackedScene
var S_player_instance: KinematicBody

func _ready():
	#Load Player
	S_player_instance = S_player.instance()
	
	if(S_player_instance):
		add_child(S_player_instance)
	
	#Load Level 
	S_level_instance = level_scene.instance()
	
	if(S_level_instance):
		add_child(S_level_instance)
		S_level_instance.set_player_instance(S_player_instance)
	
	S_player_instance.grid_map = S_level_instance