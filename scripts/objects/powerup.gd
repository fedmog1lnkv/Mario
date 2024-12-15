class_name PowerUp extends Resource

@export var id: String
@export var name: String
@export var bonuses: Array[PowerupBonus]
@export var texture: Texture2D

func get_bonus_value(type: String) -> float:
	var quantity: float = 0
	for bonus in bonuses:
		if bonus.type == type:
			quantity += bonus.value
	return quantity


static func get_bonus_value_all(powerups: Array[PowerUp], type: String) -> float:
	var quantity: float = 0
	for powerup in powerups:
		quantity += powerup.get_bonus_value(type)
	return quantity
