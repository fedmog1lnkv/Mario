extends Sprite2D

@export var target: Sprite2D

func _process(delta: float) -> void:
	if is_instance_valid(target):
		frame = target.frame
