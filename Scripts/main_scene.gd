class_name MainScene extends Node2D

@onready var hud = get_tree().get_first_node_in_group("HUD")

var main_menu = preload("res://Scenes/UI/main_menu.tscn")
var complete_scene = preload("res://Scenes/UI/complete_level_scene.tscn")
var failed_scene = preload("res://Scenes/UI/failed_level_scene.tscn")
var timer_scene = preload("res://Scenes/UI/timer.tscn")

var current_level: Map
var current_level_id: int

func _ready() -> void:
	level_manager.load_first_level()
	hud.add_child(timer_scene.instantiate())

func call_completed_level_scene() -> void:
	hud.get_child(0).queue_free()
	
	current_level = get_tree().get_first_node_in_group("Levels")
	current_level_id = current_level.level_id
	
	var complete_scene_instance = complete_scene.instantiate()
	hud.add_child(complete_scene_instance)
	
	_add_exit_button_signal(complete_scene_instance)
	_add_replay_button_signal(complete_scene_instance)
	_add_next_level_button_signal(complete_scene_instance)
		
	_destroy_level()

func call_failed_level_scene() -> void:
	hud.get_node("Timer").queue_free()
	
	current_level = get_tree().get_first_node_in_group("Levels")
	
	var failed_scene_instance = failed_scene.instantiate()
	hud.add_child(failed_scene_instance)
	
	_add_exit_button_signal(failed_scene_instance)
	_add_replay_button_signal(failed_scene_instance)
	
	_destroy_level()

func _add_exit_button_signal(scene) -> void:
	if scene.has_signal("exit_button_pressed"):
		scene.exit_button_pressed.connect(close_game)

func _add_replay_button_signal(scene) -> void:
	if scene.has_signal("replay_button_pressed"):
		scene.replay_button_pressed.connect(replay_level)

func _add_next_level_button_signal(scene) -> void:
	if scene.has_signal("next_level_button_pressed"):
		scene.next_level_button_pressed.connect(load_next_level)

func load_next_level() -> void:
	hud.get_child(0).queue_free()
	level_manager.change_level(current_level_id + 1)

func replay_level() -> void:
	hud.get_child(0).queue_free()
	level_manager.change_level(current_level_id)

func close_game() -> void:
	get_tree().quit()

func _destroy_level() -> void:
	for child in get_children():
		if not child.is_in_group("HUD"):
			child.queue_free()
