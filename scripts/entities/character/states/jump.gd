extends CharacterState

func on_physics_process(delta: float):
	if character.jump():
		change_state("jumping")
		return
	if character.velocity.y >= 0:
		change_state("falling")
		return
	character.animate("jumping")
	character.walk()
	character.fall()
	character.fast_fall()
	character.ensure_rotation()
	character.move_and_slide()
