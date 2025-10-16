class_name LevelManager extends Node

@onready var main_scene: MainScene = get_tree().get_first_node_in_group("Main")

const LEVELS = [
	"res://Scenes/Levels/first_level.tscn",
	"res://Scenes/Levels/second_level.tscn"
]

var current_level_index = 0
var current_level = null

func _ready() -> void:
	change_level()

func change_level() -> void:
	if current_level:
		current_level.queue_free()
		current_level = null
	
	var new_level_scene = load(LEVELS[current_level_index])
	var new_level = new_level_scene.instantiate()
	
	
