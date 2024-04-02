extends CharacterBody2D

var speed: float = 500
var friction: float = 0.1
var acceleration: float = 0.1
func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func _physics_process(_delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)		
	var mouse_position = get_global_mouse_position()
	var target_direction = mouse_position - global_position
	var target_rotation = atan2(target_direction.y, target_direction.x)
	rotation = target_rotation

	
	move_and_slide()
