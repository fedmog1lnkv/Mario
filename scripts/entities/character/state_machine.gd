class_name CharacterStateMachine extends StateMachine


var character: Character


@onready var states = {
	'idle': get_node("Idle"),
	'moving': get_node("Moving"),
	'running': get_node("Running"),
	'jumping': get_node("Jumping"),
	'falling': get_node("Falling"),
	'attack': get_node("Attack"),
	'dead': get_node("Dead")
}

func init(character: Character):
	self.character = character
	
	for state in states.values():
		state.init(character)
		state.state_changed.connect(_on_state_changed);
		
	set_state(states['idle'])
	
func on_damage_taken(damage: int):
	_state.on_damage_taken(damage)

func _on_state_changed(name: String):
	match name:
		'pop': pop()
		_: set_state(states[name])
