extends CharacterState

func on_physics_process(delta: float):
	if character.jump():
		change_state("jumping")
		return
	if character.x_input == 0.0:
		change_state("idle")
		return
	if character.run_input:
		change_state("running")
		return
	if character.is_falling():
		change_state("falling")
		return
	character.animate("moving")
	character.jump()
	character.walk()
	character.fall()
	character.ensure_rotation()
	character.move_and_slide()
	process_attack()
