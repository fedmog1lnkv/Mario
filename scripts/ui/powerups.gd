extends HBoxContainer

@export var character: Character

func _ready() -> void:
	character.powerups_changed.connect(show_powerups)
	show_powerups(character.powerups)

func show_powerups(powerups: Array[PowerUp]):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	for powerup in powerups:
		var p: PowerUpUi = preload("res://scenes/powerup.tscn").instantiate()
		p.set_power_up(powerup)
		add_child(p)
