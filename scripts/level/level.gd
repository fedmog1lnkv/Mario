extends Node

@export var player: Character

@onready var spawn_point: Node2D = get_node("PlayerSpawn")

func _ready() -> void:
	EventBus.player_respawned.connect(_on_player_respawned)
	
func _on_player_respawned():
	player.position = spawn_point.transform.get_origin()
	player.respawn()
