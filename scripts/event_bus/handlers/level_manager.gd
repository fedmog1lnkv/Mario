extends Node

func _ready() -> void:
	EventBus.level_changed.connect(func (level): 
		var scene: PackedScene = load("res://scenes/levels/" + level + ".tscn")
		for child in get_children():
			remove_child(child)
			child.queue_free()
		add_child(scene.instantiate())
		)
