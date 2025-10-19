class_name LevelTimer extends Control

# Reference of the current level. Used by this class to get the time limit of a level
@onready var current_level: Map = get_tree().get_first_node_in_group("Levels")

# Timer and Timer Label. Used to calculate the time and pass it to the timer on the screen
@export var timer: Timer
@export var timer_label: Label

# Initializes the timer and starts it
func _ready() -> void:
	initialize_timer()
	start_timer()

# Call the _transfer_timer_value_to_label in a frame by frame basis
func _process(_delta: float) -> void:
	_transfer_timer_value_to_label()
	if timer.timeout:
		get_tree().quit()

# Initialize the timer, by getting the time limit of a level and passing it to the timer
func initialize_timer() -> void:
	var level_time_limit = current_level.get_time_limit()
	timer.set_wait_time(level_time_limit)

# Start the timer
func start_timer() -> void:
	timer.start()

# Stop the timer
func stop_timer() -> void:
	timer.stop()

# Transfers the current time on the timer component to the label on the screen
func _transfer_timer_value_to_label() -> void:
	var time_label_text = "{timer}"
	timer_label.text = time_label_text.format({"timer":"%0.2f" % timer.get_time_left()})
