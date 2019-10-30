extends Node

var player_spawn_point: Vector3
var puzzle_piece_spawn_point: PoolVector3Array

func find_spawn_points(gridmap: GridMap):
	for grid in gridmap.get_used_cells():
			grid as Vector3
			if gridmap.mesh_library.get_item_name(gridmap.get_cell_item(grid.x, grid.y, grid.z)) == "spawn":
				player_spawn_point = _translate_spawn_point(grid)
			elif gridmap.mesh_library.get_item_name(gridmap.get_cell_item(grid.x, grid.y, grid.z)) == "puzzle_piece_spawn":
				var puzzle_spawn = _translate_spawn_point(grid)
				print(puzzle_spawn)
				puzzle_piece_spawn_point.append(puzzle_spawn)

func _translate_spawn_point(spawn_point: Vector3) -> Vector3:
	spawn_point.y += 1.5
	spawn_point.z += 0.5
	spawn_point.x += 0.5
	return spawn_point
	

