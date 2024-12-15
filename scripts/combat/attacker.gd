class_name Attacker extends Node2D

@onready var hitbox: HitBox = get_node("HitBox")

var timer: float = 0

var swing_timer: float = 0

var is_attacking = false
var swing_passed = false

func _ready():
	hitbox.owner_entity = owner
	hitbox.disable()

func attack(damage: int, attack_duration: float, swing_duration: float):
	hitbox.disable()
	is_attacking = true
	swing_passed = false
	hitbox.damage = damage
	timer = attack_duration
	swing_timer = swing_duration
	
func _physics_process(delta: float) -> void:
	if is_attacking:
		if swing_timer <= 0 and not swing_passed:
			swing_passed = false
			hitbox.enable()
		if timer <= 0:
			hitbox.disable()
		timer -= delta
		swing_timer -= delta
		
			
	
