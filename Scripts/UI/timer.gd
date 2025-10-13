extends Control

@onready var current_level: Map = get_tree().get_first_node_in_group("Levels")
@onready var timer: Timer = Timer.new()
@export var timer_label: Label


func _ready() -> void:
	initialize_timer()
	start_timer()

func _process(_delta: float) -> void:
	_transfer_timer_value_to_label()

func initialize_timer() -> void:
	var level_time_limit = current_level.get_time_limit()
	timer.set_wait_time(level_time_limit)

func start_timer() -> void:
	timer.autostart = true
	
func stop_timer() -> void:
	timer.stop()
	
func _transfer_timer_value_to_label() -> void:
	timer_label.text = str(timer.get_time_left())
