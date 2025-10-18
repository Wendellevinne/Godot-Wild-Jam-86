extends Control

@export var exit_button: Button
@export var retry_button: Button
@export var next_level_button: Button

signal exit_button_pressed
signal replay_button_pressed
signal next_level_button_pressed

func _on_exit_button_pressed() -> void:
	emit_signal("exit_button_pressed")

func _on_replay_button_pressed() -> void:
	emit_signal("replay_button_pressed")

func _on_next_button_pressed() -> void:
	emit_signal("next_level_button_pressed")
