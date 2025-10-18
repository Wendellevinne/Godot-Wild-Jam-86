class_name LevelManager extends Node

@onready var main_scene: MainScene = get_tree().get_first_node_in_group("Main")

const LEVELS = [
	"res://Scenes/Levels/first_level.tscn",
	"res://Scenes/Levels/second_level.tscn"
]

var current_level: Map = null

func load_first_level() -> void:
	change_level(0)

func change_level(level_number: int) -> void:
	if level_number > LEVELS.size() - 1:
		return
	
	if current_level:
		current_level.queue_free()
		current_level = null
	
	var new_level_scene = load(LEVELS[level_number])
	var new_level = new_level_scene.instantiate()
	
	main_scene.add_child(new_level)
	current_level = new_level
