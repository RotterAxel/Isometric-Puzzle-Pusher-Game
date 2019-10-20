extends Node

#Level Variables
onready var S_level1 = preload("res://Levels/S_Level1.tscn") as PackedScene
var S_level1_instance

#Player Variables
onready var S_player = preload("res://Player/S_player.tscn") as PackedScene
var S_player_instance: Spatial

func _ready():
	#Load Level 1
	S_level1_instance = S_level1.instance()
	
	if(S_level1_instance):
		add_child(S_level1_instance)
	
	#Load Player
	S_player_instance = S_player.instance()
	
	if(S_player_instance):
		add_child(S_player_instance)
	
	print(S_player_instance.transform.translated(S_level1_instance.spawn_point))
	S_player_instance.spawn_point = S_level1_instance.spawn_point
	