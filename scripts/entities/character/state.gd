class_name CharacterState extends State

var character: Character

func init(character: Character):
	self.character = character

func process_attack():
	if character.attack_input:
		change_state('attack')
