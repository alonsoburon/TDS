# FILEPATH: /c:/Users/nuxap/Documents/GitHub/TDS/player.gd

extends CharacterBody2D

# The speed at which the player moves
var speed: float = 500

# The friction applied to the player's movement
var friction: float = 0.1

# The acceleration applied to the player's movement
var acceleration: float = 0.1

var sword_move_speed: float = 5

var sword_rotation_speed: float = .25

# The rotation speed of the player
var rot_speed = 10

var player_size = Vector2(5, 5)

# Function to map a value from one range to another
func map_range(value, in_min, in_max, out_min, out_max):
	return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min

# Retrieves the player's input, used in _physics_process
func get_input() -> Vector2:
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

func get_rotate_to_mouse() :
	var target_position = get_local_mouse_position() # Get the mouse position in the world
	var new_transform = $player_sprite.transform.looking_at(target_position)
	return new_transform
# This script controls the movement and rotation of the player character.

func _physics_process(_delta):
	"""
	Physics process function that is called every frame to update the player's movement and rotation.

	:param _delta: The time elapsed since the last frame.
	"""
	$player_sprite.scale = player_size
	var direction = get_input() # Run previous function to get input, value is a Vector2 pointing in the direction of the input
	if direction.length() > 0: # This means if movement is detected
		velocity = lerp(velocity, direction.normalized() * speed, acceleration) # Lerp the velocity from whatever it ism to the direction * speed with acceleration
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction) # If no movement detected, lerp the velocity to 0 with friction

	# Calculate the target position for the sword_sprite
	var mouse_pos = get_global_mouse_position()
	var sword_direction = (mouse_pos - global_position).normalized()
	var sword_distance = min((mouse_pos - global_position).length(), 100)
	var sword_target_position = global_position + sword_direction * sword_distance

	# Interpolate the sword sprite's position to the target position
	$sword.global_position = $sword.global_position.lerp(sword_target_position, _delta * sword_move_speed)

	var sword_point = mouse_pos - $sword.global_position
	var sword_angle = sword_point.angle()
	var sword_rotation = $sword.rotation
	$sword.rotation = lerp_angle(sword_rotation, sword_angle, sword_rotation_speed) 

	#print(angle_sword)


	move_and_slide()
