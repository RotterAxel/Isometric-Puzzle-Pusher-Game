extends Spatial

var spawn_point:Vector3 = Vector3()
onready var GRID_MAP = $GridMap as GridMap

func _ready():
	for grid in GRID_MAP.get_used_cells():
		grid as Vector3
		#print(str(GRID_MAP.get_cell_item(grid.x, grid.y, grid.z)))
		if GRID_MAP.mesh_library.get_item_name(GRID_MAP.get_cell_item(grid.x, grid.y, grid.z)) == "spawn":
			#print(str(grid) + 
				#str(GRID_MAP.mesh_library.get_item_name(GRID_MAP.get_cell_item(grid.x, grid.y, grid.z))))
			grid.y += 1
			spawn_point = grid