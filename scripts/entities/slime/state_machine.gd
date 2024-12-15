class_name SlimeStateMachine extends StateMachine

@onready var states = {
	'running': get_node("Running"),
	'dead': get_node("Dead"),
	'idle': get_node("Idle")
}

var character: Slime

func init(character: Slime):
	self.character = character
	
	for state in states.values():
		state.init(character)
		state.state_changed.connect(_on_state_changed);
		
	set_state(states['running'])
	
func on_damage_taken(damage: int):
	_state.on_damage_taken(damage)
	
func _on_state_changed(name: String):
	match name:
		'pop': pop()
		_: set_state(states[name])
