extends Node

func are_grid_points_out_of_bounds(used_cells: PoolVector3Array, out_of_bounds_positions: PoolVector3Array):
	
	var cell_taken = false;
	
	for position in out_of_bounds_positions:
		for cell in used_cells:
			if position == cell:
				cell_taken = true
				print("Test Failed: Out of bounds grid points are grid cells " + str(position) + str(cell))
				break
				
	
	if cell_taken == false:
		print("Test passed: Out of bounds grid points are not grid cells")
		

func are_out_of_bounds_points_unique(out_of_bounds_positions: PoolVector3Array):
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
	
	if duplicate_indexes.size() == 0:
		print("Test passed: Out of bounds points are unique")
	else:
		print("Test failed: Out of bounds points are not unique")

func visualize_out_of_bounds_cells(grid_map: GridMap, out_of_bounds_positions: PoolVector3Array):
	var snowitem = grid_map.mesh_library.find_item_by_name("snow")
	var snowshape = grid_map.mesh_library.get_item_shapes(snowitem)
	
	for out_of_bounds in SI_out_of_bounds.out_of_bounds_positions:
		out_of_bounds = out_of_bounds as Vector3
		var x = out_of_bounds.x
		var y = out_of_bounds.y
		var z = out_of_bounds.z
		grid_map.set_cell_item(x, y, z, 3, 0)
	print("Test: Out of bounds cells are being visualized")