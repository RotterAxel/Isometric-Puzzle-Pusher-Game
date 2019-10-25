extends Node

#Level Variables
export var level_scene: PackedScene
var S_level_instance



func _ready():
	#Load Level 
	S_level_instance = level_scene.instance()
	
	if(S_level_instance):
		add_child(S_level_instance)
	
	#DEBUGGER: Print the entire Player Transform to the Spawn Point
	#print(S_player_instance.transform.translated(S_level1_instance.spawn_point))
	
	