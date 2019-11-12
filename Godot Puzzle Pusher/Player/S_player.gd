extends KinematicBody

#Local Variables
var direction = Vector3()
export var speed = 0
const MAX_SPEED = 10
var velocity = Vector3()

var world_target_pos = Vector3()
var target_direction = Vector3()
var is_moving = false

#Current Level
var grid_map: GridMap

func _ready():
	pass

func _process(delta):
	direction = Vector3()
	speed = 0
	if Input.is_action_just_pressed("ui_up"):
		direction.x +=1
	elif Input.is_action_just_pressed("ui_down"):
		direction.x -=1
	elif Input.is_action_just_pressed("ui_left"):
		direction.z -=1
	elif Input.is_action_just_pressed("ui_right"):
		direction.z +=1
	
	if not is_moving and direction != Vector3(): 
		target_direction = direction.normalized()
		is_moving = true
		world_target_pos = grid_map.is_cell_vacant(translation, target_direction)
		
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction * delta
		var distance_to_target = translation.distance_to(world_target_pos)
		var move_distance = velocity.length()
		
		if distance_to_target < move_distance:
			velocity = target_direction * distance_to_target
			is_moving = false
		
		move_and_collide(velocity)