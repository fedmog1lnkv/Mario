class_name SlimeState extends State

var character: Slime

func init(character: Slime):
	self.character = character

func on_damage_taken(damage: int):
	character.health -= damage	

	if character.health <= 0:
		character.dead_player.play()
		change_state('dead')
