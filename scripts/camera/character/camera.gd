extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var playerRemoteTransform2d = get_tree().current_scene.get_node("Player/RemoteTransform2D");
	playerRemoteTransform2d.remote_path = get_path();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
