extends CharacterState

func on_physics_process(delta: float):
	if not character.is_falling():
		change_state("idle")
		return
	character.animate("falling")
	character.walk()
	character.fall()
	character.fast_fall()
	character.ensure_rotation()
	character.move_and_slide()
