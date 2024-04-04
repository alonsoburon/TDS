# FILEPATH: /c:/Users/nuxap/Documents/GitHub/TDS/player.gd

extends CharacterBody2D

# The speed at which the player moves
var speed: float = 500

# The friction applied to the player's movement
var friction: float = 0.1

# The acceleration applied to the player's movement
var acceleration: float = 0.1

# The rotation speed of the player
var rot_speed = 10

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

	var direction = get_input() # Run previous function to get input, value is a Vector2 pointing in the direction of the input
	if direction.length() > 0: # This means if movement is detected
		velocity = lerp(velocity, direction.normalized() * speed, acceleration) # Lerp the velocity from whatever it ism to the direction * speed with acceleration
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction) # If no movement detected, lerp the velocity to 0 with friction

	 # Get the transform of the player sprite looking at the mouse position
	$player_sprite.transform = $player_sprite.transform.interpolate_with(get_rotate_to_mouse(), rot_speed * _delta) # Interpolate the player sprite's transform to the mouse position with the rotation speed

	move_and_slide()
