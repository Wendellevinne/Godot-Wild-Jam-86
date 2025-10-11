class_name Player extends CharacterBody2D

var move_speed: int = 400
var jump_velocity: int = -500

var can_double_jump: bool = false
var can_air_dash: bool = false

func _physics_process(delta: float) -> void:
	vertical_movement(delta)
	horizontal_movement()
	move_and_slide()

func horizontal_movement() -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

func vertical_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

func change_character_movement(new_move_speed: int, new_jump_velocity: int) -> void:
	move_speed = new_move_speed
	jump_velocity = new_jump_velocity

func _on_detection_area_area_entered(area: Area2D) -> void:
	collision_manager.process_collision(self, area)
