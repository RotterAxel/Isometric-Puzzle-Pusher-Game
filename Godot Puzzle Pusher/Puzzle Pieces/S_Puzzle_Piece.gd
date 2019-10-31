extends KinematicBody

var direction = Vector3() setget set_direction
export var speed = 0
const MAX_SPEED = 10
var velocity = Vector3()

var world_target_pos = Vector3()
var target_direction = Vector3()
var is_moving = false

func set_direction(dir: Vector3):
	direction = dir

func _process(delta):
	speed = 0
	if not is_moving and direction != Vector3(): 
		target_direction = direction.normalized()
		direction = Vector3()
		is_moving = true
		world_target_pos = translation + target_direction
		
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction * delta
		var distance_to_target = translation.distance_to(world_target_pos)
		var move_distance = velocity.length()
		
		if distance_to_target < move_distance:
			velocity = target_direction * distance_to_target
			is_moving = false
		
		move_and_collide(velocity)