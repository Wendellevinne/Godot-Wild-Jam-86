class_name Player extends CharacterBody2D

# Variables related with the character movement

# Ground speed
@export var move_speed: float = 1000

# Air Dash Speed
@export var air_dash_speed: float = 1500

# Deceleration rate of the air dash 
@export var air_dash_slowdown_rate: float = 200

# Jump height
@export var jump_velocity: float = -500

# Specifies for how many frames jump press is valid
@export var coyote_frames: int = 6

# Amount of time the character is considered in the air dash state. Once the time ends, the character
# returns to its "neutral" state
@export var air_dash_timer: Timer

# Keeps track of how many frames passed from the last moment the player was on ground
var frames_since_grounded: int = 0

# Checks whether the character has the air-dash mask equipped
var air_dash_mask: bool = false

# Checks if the player can air dash
var can_air_dash: bool = false

# Checks if the player is in the middle of a air dash
var is_on_air_dash: bool = false

# Saves variable for coyote time
var was_jump_pressed: bool = false

# Saves the dash direction
var dash_direction: float = 0


# Call all the functions regarding the movement of the character
func _physics_process(delta: float) -> void:
	vertical_movement(delta)
	horizontal_movement(delta)
	move_and_slide()

# Handle horizontal movement.
func horizontal_movement(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Check if direction is different than 0. If so, move the character that way (1 for right
	# -1 for left). If direction is equal to 0, the character doesn't move horizontally
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	# Stop dash on direction change
	if direction != dash_direction:
		is_on_air_dash = false
	
	# Handle air dash. Activated when Left Shift or Space is pressed, and can_air_dash is true,
	# and the player has the air dash mask, and it is not on the floor
	if Input.is_action_just_pressed("air_dash") and can_air_dash and air_dash_mask and not is_on_floor():
		dash_direction = direction
		is_on_air_dash = true
		can_air_dash = false
		air_dash_timer.start(1)
	
	# Executes the air dash movement, if the character is during one
	if is_on_air_dash:
		velocity.x = dash_direction * air_dash_speed - (air_dash_slowdown_rate * delta)

#Handle vertical movement
func vertical_movement(delta: float) -> void:
	# Add the gravity. If the player is on a air dash, it doesn't lose height
	if not is_on_floor() and not is_on_air_dash:
		velocity += get_gravity() * delta
		
	if is_on_floor():
		frames_since_grounded = 0
	else:
		frames_since_grounded += 1
	
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or frames_since_grounded <= coyote_frames:
			velocity.y = jump_velocity
			frames_since_grounded += 1
	
	# When the player touches the ground, reset all their movement options
	if is_on_floor():
		reset_movement_options()

# Reset movement options of the player (E.G. double jump, air dash...)
func reset_movement_options() -> void:
	is_on_air_dash = false
	can_air_dash = true

# Enable air dash. Disables all other movement options when enabled
func enable_air_dash() -> void:
	air_dash_mask = true

# Change the move speed 
func change_move_speed(new_move_speed: int) -> void:
	move_speed = new_move_speed

func change_jump_velocity(new_jump_velocity: int) -> void:
	jump_velocity = new_jump_velocity

func _on_air_dash_timer_timeout() -> void:
	is_on_air_dash = false
