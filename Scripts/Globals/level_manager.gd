class_name LevelManager extends Node

# Main scene object reference. Used by this class to add the levels to it
@onready var main_scene: MainScene = get_tree().get_first_node_in_group("Main")

# A list of all the levels existent in the game. They are instantiated and added by the change_level
# function.
const LEVELS = [
	"res://Scenes/Levels/first_level.tscn",
	"res://Scenes/Levels/second_level.tscn"
]

# A current level reference of the current level present in the main tree
var current_level: Map = null

# Load the first level
func load_first_level() -> void:
	change_level(0)

# Change the level in the main scene tree and in the reference, based on the level ID received
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
