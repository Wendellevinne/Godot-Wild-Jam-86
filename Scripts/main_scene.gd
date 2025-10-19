class_name MainScene extends Node2D

# HUD element present in the main scene. Used in add and remove HUD scene operations
@onready var hud = get_tree().get_first_node_in_group("HUD")

# Preloads used in this script
var main_menu = preload("res://Scenes/UI/main_menu.tscn")
var complete_scene = preload("res://Scenes/UI/complete_level_scene.tscn")
var failed_scene = preload("res://Scenes/UI/failed_level_scene.tscn")
var timer_scene = preload("res://Scenes/UI/timer.tscn")

# Referente to the current map and its level id, which is used by the level manager
var current_level: Map
var current_level_id: int

# TODO Implement the main menu and make it appear by calling this method
func _ready() -> void:
	level_manager.load_first_level()

# Call the completed level scene to the HUD
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

# TODO Create the logic to call this function in the game
# Call the failed level UI to the HUD


# Connects the _on_exit_button_pressed signal to this scene
func _add_exit_button_signal(scene) -> void:
	if scene.has_signal("exit_button_pressed"):
		scene.exit_button_pressed.connect(close_game)

# Connects the _on_replay_button_pressed signal to this scene
func _add_replay_button_signal(scene) -> void:
	if scene.has_signal("replay_button_pressed"):
		scene.replay_button_pressed.connect(replay_level)

# Connects the _on_next_level_button_pressed signal to this scene
func _add_next_level_button_signal(scene) -> void:
	if scene.has_signal("next_level_button_pressed"):
		scene.next_level_button_pressed.connect(load_next_level)

# Recreate the previous level, so it can be replayed. TODO Implement a HUD logic, instead of manipulating it
# directly from here
func load_next_level() -> void:
	hud.get_child(0).queue_free()
	level_manager.change_level(current_level_id + 1)

# Recreate the previous level, so it can be replayed. TODO Implement a HUD logic, instead of manipulating it
# directly from here
func replay_level() -> void:
	hud.get_child(0).queue_free()
	level_manager.change_level(current_level_id)

# Close the game
func close_game() -> void:
	get_tree().quit()

# Destroy all the other nodes, excluiding the ones present in the HUD
func _destroy_level() -> void:
	for child in get_children():
		if not child.is_in_group("HUD"):
			child.queue_free()
