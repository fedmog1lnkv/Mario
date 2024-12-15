extends Node

func _ready() -> void:
	EventBus.loot_gained.connect(_on_loot_gained)
	
func _on_loot_gained(character: Node2D, loot: PowerUp):
	if character != null and character.has_method('add_powerup'):
		character.add_powerup(loot)
