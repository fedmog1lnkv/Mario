extends CharacterState

func on_enter():
	EventBus.player_died.emit()
	character.animate("dying")

func on_physics_process(delta: float):
	character.velocity.x = 0
	character.fall()
	character.move_and_slide()
   
func on_damage_taken(damage: int):
	pass
