extends GridMap

#Run Tests Variable
export var test_mode = false;

#Player Variables
onready var S_player = preload("res://Player/S_player.tscn") as PackedScene
var S_player_instance: KinematicBody
var player_position: Vector3

#Puzzle Piece Variables
onready var S_puzzle_piece = preload("res://Puzzle Pieces/S_Puzzle_Piece.tscn") as PackedScene
var S_puzzle_piece_array: Array
var puzzle_piece_positions: PoolVector3Array


func _ready():
	SI_out_of_bounds.calculate_out_of_bounds_positions(self)
	
	#Find Spawn Points for Player and Puzzle Pieces
	SI_spawn_point.find_spawn_points(self)
	
	#Load Player and translate to Spawn Position
	S_player_instance = S_player.instance() as KinematicBody
	S_player_instance.translate(SI_spawn_point.player_spawn_point)
	player_position = S_player_instance.translation
	add_child(S_player_instance)
	
	#Load Puzzle Pieces
	for puzzle_spawn in SI_spawn_point.puzzle_piece_spawn_point:
		var puzzle_piece_instance = S_puzzle_piece.instance() as KinematicBody
		add_child(puzzle_piece_instance)
		puzzle_piece_instance.translate(puzzle_spawn)
		puzzle_piece_positions.append(puzzle_piece_instance.translation)
		S_puzzle_piece_array.append(puzzle_piece_instance)
	
	if test_mode:
		SI_Test_Script.are_grid_points_out_of_bounds(self.get_used_cells(), SI_out_of_bounds.out_of_bounds_positions)
		SI_Test_Script.are_out_of_bounds_points_unique(SI_out_of_bounds.out_of_bounds_positions)
		SI_Test_Script.visualize_out_of_bounds_cells(self, SI_out_of_bounds.out_of_bounds_positions)


func is_cell_vacant(this_world_pos=Vector3(), direction=Vector3()) -> Vector3:
	var new_position
	var target_grid_pos = world_to_map(this_world_pos) + direction
	
	#True if the player is trying to go out of bounds or a Puzzle piece bieng pushed out of bounds
	var out_of_bounds = false
	var puzzle_piece_collides = false
	
	#Is the player trying to move out of bounds
	if _is_moving_out_of_bounds(target_grid_pos) == false:
		for puzzle_piece in S_puzzle_piece_array:
			#Get Puzzle piece if it lies in the path of the target direction of the player
			if world_to_map(puzzle_piece.translation) == target_grid_pos:
				#Is the puzzle piece trying to move out of bounds
				if _is_moving_out_of_bounds(world_to_map(puzzle_piece.translation + direction)) == false:
					#Check if this piece + direction will collide with another piece
					for piece_position in puzzle_piece_positions:
						if world_to_map(puzzle_piece.translation + direction) == world_to_map(piece_position):
							puzzle_piece_collides = true
						
					if !puzzle_piece_collides:
						puzzle_piece = puzzle_piece as KinematicBody
						puzzle_piece.set_direction(direction)
					else:
						return this_world_pos
				else:
					return this_world_pos
	elif _is_moving_out_of_bounds(target_grid_pos) == true:
		return this_world_pos
	
	new_position = map_to_world(target_grid_pos.x, target_grid_pos.y, target_grid_pos.z)
	update_puzzle_positions()
	return new_position
	
func update_puzzle_positions():
	puzzle_piece_positions = PoolVector3Array()
	for piece in S_puzzle_piece_array:
		puzzle_piece_positions.append(piece.translation)
		

func _is_moving_out_of_bounds(target_grid_position: Vector3) -> bool:
	var target_grid_position_adapted = target_grid_position
	target_grid_position_adapted.y -= 1;
	for out_of_bound_position in SI_out_of_bounds.out_of_bounds_positions:
		if out_of_bound_position == target_grid_position_adapted:
			return true
	return false