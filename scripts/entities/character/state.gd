class_name CharacterState extends State

var character: Character

func init(character: Character):
	self.character = character

func process_attack():
	if character.attack_input:
		change_state('attack')


func on_damage_taken(damage: int):
	character.health -= damage
	
	if character.health <= 0:
		change_state('dead')
