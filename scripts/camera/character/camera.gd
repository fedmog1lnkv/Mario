extends Camera2D

@export var target: Node2D

func _physics_process(delta: float) -> void:
	position = target.transform.get_origin()
