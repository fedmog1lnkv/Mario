extends Node

const _items = [
	preload("res://resources/powerups/double_jump.tres")
]

func _init() -> void:
	for item in _items:
		data[item.id] = item

var data = {}

func get_item(id: String) -> PowerUp:
	return data[id]
