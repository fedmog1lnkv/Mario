extends SlimeState

func on_physics_process(delta: float):
	if character.x_input != 0:
		change_state("running")
	character.animation_player.play("idle")
	character.ensure_rotation()
	character.move_and_slide()
	character.run()
	character.fall()
