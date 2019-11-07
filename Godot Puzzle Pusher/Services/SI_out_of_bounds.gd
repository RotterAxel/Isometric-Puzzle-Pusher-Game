extends Node

var out_of_bounds_positions: PoolVector3Array

var directions: PoolVector3Array



func _ready():
	directions.append(Vector3(1,0,0))
	directions.append(Vector3(-1,0,0))
	directions.append(Vector3(0,0,1))
	directions.append(Vector3(0,0,-1))

func calculate_out_of_bounds_positions(gridMap: GridMap):
	var used_cells = gridMap.get_used_cells() as PoolVector3Array
	
	var is_cell_taken = false
	
	for cell in used_cells:
		cell = cell as Vector3
		for i in range(0,4):
			var cell_taken = false
			var neighbour_direction = cell + directions[i]
			for cell1 in used_cells:
				if cell == cell1:
					continue
				if neighbour_direction == cell1:
					cell_taken = true
					continue
			if cell_taken == false:
				out_of_bounds_positions.append(neighbour_direction)
		
		remove_double_entries()


func remove_double_entries():
	#Delete double entries in out of bounds
	if out_of_bounds_positions.size() < 2:
		return []

	var seen = {}
	seen[out_of_bounds_positions[0]] = true
	var duplicate_indexes = []
	
	for i in range(1, out_of_bounds_positions.size()):
		var v = out_of_bounds_positions[i]
		if seen.has(v):
			# Duplicate!
			duplicate_indexes.append(i)
		else:
			seen[v] = true
	
	if duplicate_indexes.size() > 0:
		for double in duplicate_indexes:
			out_of_bounds_positions.remove(double)