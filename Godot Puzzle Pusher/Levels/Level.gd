extends GridMap

#Player Variables
onready var S_player = preload("res://Player/S_player.tscn") as PackedScene
var S_player_instance: KinematicBody

#Puzzle Piece Variables
onready var S_puzzle_piece = preload("res://Puzzle Pieces/S_Puzzle_Piece.tscn") as PackedScene
var S_puzzle_piece_array: Array

func _ready():
	SI_spawn_point.find_spawn_points(self)
	
	#Load Player
	S_player_instance = S_player.instance()
	
	#Inject PLAYER with information
	S_player_instance.spawn_point = SI_spawn_point.player_spawn_point
	
	if(S_player_instance):
		add_child(S_player_instance)
	
	#Load Puzzle Pieces
	for puzzle_spawn in SI_spawn_point.puzzle_piece_spawn_point:
		var puzzle_piece_instance = S_puzzle_piece.instance() as RigidBody
		add_child(puzzle_piece_instance)
		puzzle_piece_instance.translate(puzzle_spawn)
		S_puzzle_piece_array.append(puzzle_piece_instance)


func is_cell_vacant(this_grid_pos=Vector3(), direction=Vector3()) -> Vector3:
	var target_grid_pos = world_to_map(this_grid_pos) + direction
	var new_position = map_to_world(target_grid_pos.x, target_grid_pos.y, target_grid_pos.z)
	return new_position