extends Control

@onready var background: ColorRect = get_node("ColorRect")

func _ready() -> void:
	EventBus.player_died.connect(_on_player_died)
	visible = false

func _on_player_died():
	visible = true
	$DeadPlayer.play()

func _on_respawn_pressed() -> void:
	EventBus.player_respawned.emit()
	visible = false


func _on_menu_pressed() -> void:
	EventBus.level_changed.emit('main_menu')
