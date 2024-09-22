extends CharacterState

func on_physics_process(delta: float):
	if character.jump():
		change_state("jumping")
		return
	if character.x_input != 0.0:
		change_state("moving")
		return
	if character.is_falling():
		change_state("falling")
		return
	character.animate("idle")
	character.walk()
	character.ensure_rotation()
	character.fall()
	character.move_and_slide()
