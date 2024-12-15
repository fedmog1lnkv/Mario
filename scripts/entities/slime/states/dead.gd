extends SlimeState

func on_enter():
	character.animation_player.play("die")
	character.run()
	character.fall()
	character.collision_layer = 2
	character.hitbox.disable()

func on_damage_taken(damage: int):
	pass
