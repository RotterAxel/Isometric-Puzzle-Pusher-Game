extends Node

var _spawn_point:Vector3

func find_spawn_point(gridmap: GridMap) -> Vector3:
	for grid in gridmap.get_used_cells():
			grid as Vector3
			if gridmap.mesh_library.get_item_name(gridmap.get_cell_item(grid.x, grid.y, grid.z)) == "spawn":
				grid.y += 1.5
				grid.z += 0.5
				grid.x += 0.5
				_spawn_point = grid
	if(_spawn_point):
		return _spawn_point
	else:
		print("No item with the name spawn found in mesh_library")
		return _spawn_point
