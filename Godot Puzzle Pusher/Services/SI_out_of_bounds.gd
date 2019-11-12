extends Node

var out_of_bounds_positions: PoolVector3Array

var directions: PoolVector3Array

func _ready():
	directions.append(Vector3(1,0,0))
	directions.append(Vector3(-1,0,0))
	directions.append(Vector3(0,0,1))
	directions.append(Vector3(0,0,-1))

func calculate_out_of_bounds_positions(gridMap: GridMap):
	out_of_bounds_positions = PoolVector3Array()
	
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
		
	_remove_double_entries()
	_add_out_of_bounds_top_and_bottom()


func _remove_double_entries():
	#Delete double entries in out of bounds
	if out_of_bounds_positions.size() < 2:
		return []

	var seen = {}
	seen[out_of_bounds_positions[0]] = true
	
	for i in range(1, out_of_bounds_positions.size()):
		var v = out_of_bounds_positions[i]
		if !seen.has(v):
			seen[v] = true
	
	out_of_bounds_positions = PoolVector3Array()
	for seen_position in seen:
		out_of_bounds_positions.append(seen_position)
	

func _add_out_of_bounds_top_and_bottom():
	var top_bottom_positions_to_append = PoolVector3Array()
	
	for position in out_of_bounds_positions:
		var top_piece = position as Vector3
		top_piece.y += 1
		var bottom_piece = position as Vector3
		bottom_piece.y -= 1
		
		top_bottom_positions_to_append.append(top_piece)
		top_bottom_positions_to_append.append(bottom_piece)
	
	for position in top_bottom_positions_to_append:
		out_of_bounds_positions.append(position)