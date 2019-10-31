extends GridMap

#Player Variables
onready var S_player = preload("res://Player/S_player.tscn") as PackedScene
var S_player_instance: KinematicBody
var player_position: Vector3

#Puzzle Piece Variables
onready var S_puzzle_piece = preload("res://Puzzle Pieces/S_Puzzle_Piece.tscn") as PackedScene
var S_puzzle_piece_array: Array
var puzzle_piece_positions: PoolVector3Array

func _ready():
	SI_spawn_point.find_spawn_points(self)
	
	#Load Player and Inject Spawn Position
	S_player_instance = S_player.instance() as KinematicBody
	S_player_instance.translate(SI_spawn_point.player_spawn_point)
	player_position = S_player_instance.translation
	
	if(S_player_instance):
		add_child(S_player_instance)
	
	#Load Puzzle Pieces
	for puzzle_spawn in SI_spawn_point.puzzle_piece_spawn_point:
		var puzzle_piece_instance = S_puzzle_piece.instance() as KinematicBody
		add_child(puzzle_piece_instance)
		puzzle_piece_instance.translate(puzzle_spawn)
		puzzle_piece_positions.append(puzzle_piece_instance.translation)
		S_puzzle_piece_array.append(puzzle_piece_instance)


func is_cell_vacant(this_world_pos=Vector3(), direction=Vector3()) -> Vector3:
	var new_position
	var target_grid_pos = world_to_map(this_world_pos) + direction
	
	var puzzle_piece_collides = false
	
	for puzzle_piece in S_puzzle_piece_array:
		if world_to_map(puzzle_piece.translation) == target_grid_pos:
			#Check if this piece + direction will collide with another piece
			for piece_position in puzzle_piece_positions:
				if world_to_map(puzzle_piece.translation + direction) == world_to_map(piece_position):
					print("Puzzle piece collides")
					puzzle_piece_collides = true
			
			if !puzzle_piece_collides:
				puzzle_piece = puzzle_piece as KinematicBody
				puzzle_piece.set_direction(direction)
			else:
				return this_world_pos
	new_position = map_to_world(target_grid_pos.x, target_grid_pos.y, target_grid_pos.z)
	update_puzzle_positions()
	return new_position
	
func update_puzzle_positions():
	puzzle_piece_positions = PoolVector3Array()
	for piece in S_puzzle_piece_array:
		puzzle_piece_positions.append(piece.translation)