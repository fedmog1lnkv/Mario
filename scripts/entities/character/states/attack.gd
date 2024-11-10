extends CharacterState

var timer: float = 0

func on_enter():
	timer = character.attack_duration
	character.animate("attack")
	character.attacker.attack(50, character.attack_duration, character.swing_duration    )

func on_physics_process(delta: float):
	timer -= delta
	if timer <= 0:
		pop()
		return
	character.velocity.x = 0
	character.fall()
	character.move_and_slide()
   
