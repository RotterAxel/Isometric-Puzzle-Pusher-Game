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
	
	test_out_of_bounds_is_correct(used_cells)

func test_out_of_bounds_is_correct(used_cells: PoolVector3Array):
	
	var cell_taken = false;
	
	for position in out_of_bounds_positions:
		for cell in used_cells:
			if position == cell:
				cell_taken = true
				print("Test Failed: " + str(position) + str(cell))
				break
				
	
	if cell_taken == false:
		print("Test Passed")

func remove_double_entries():
	var double_entry = out_of_bounds_positions[0]
	out_of_bounds_positions.append(double_entry)
	
	print("Out of bounds size " + str(out_of_bounds_positions.size()))
	
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
	