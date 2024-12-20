extends Camera2D

func _physics_process(delta: float) -> void:
	position.x += delta * 25
