extends Node


func _on_play_button_pressed() -> void:
	EventBus.level_changed.emit('level_1')

func _on_exit_button_pressed() -> void:
	get_tree().quit()
