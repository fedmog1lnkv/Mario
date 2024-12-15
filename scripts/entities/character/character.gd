class_name Character
extends CharacterBody2D

@export var walk_speed = 50.0
@export var run_speed = 75.0
@export var jump_force = 200.0
@export var coyote_time = 0.1
@export var health = 100

var gravity_magnitude : float = 9.8
var attack_duration = 0.6
var swing_duration = 0.35

var x_input = 0.0
var jump_input = false
var down_input = false
var run_input = false
var attack_input = false

@onready var _standing_collision: CollisionShape2D = get_node("Shape")
@onready var _skin_node: Node2D = get_node("Skin")
@onready var _animation_player: AnimationPlayer = get_node("PlayerAnimation")

@onready var _state_machine: CharacterStateMachine = get_node("StateMachine")

@onready var attacker: Attacker = get_node("Attacker")
@onready var hurtbox: HurtBox = get_node("Hurtbox")

signal powerups_changed(powerups: Array[PowerUp])

var coyoute_timer: float = 0
var air_jumps = 0

var powerups: Array[PowerUp] = []

func add_powerup(powerup: PowerUp):
	powerups.append(powerup)
	powerups_changed.emit(powerups)

func respawn():
	_state_machine._on_state_changed('idle')
	health = 100

func count_coyoute_timer(delta: float):
	if velocity.y <= 0:
		coyoute_timer = coyote_time	
	elif coyoute_timer > 0:
		coyoute_timer -= delta
	
func animate(name: String):
	_animation_player.play(name)
	
func walk():
	velocity.x = x_input * walk_speed
	
func run():
	velocity.x = x_input * run_speed
	
func fall():
	if not is_on_floor():
		velocity.y += gravity_magnitude
	else:
		air_jumps = 0
		
func jump() -> bool:
	if not jump_input:
		return false
	if not is_falling() and not is_jumping():
		velocity.y = -jump_force
		coyoute_timer = 0
		return true
	var max_air_jump = PowerUp.get_bonus_value_all(powerups, 'jump_count')
	
	if air_jumps < max_air_jump:
		velocity.y = -jump_force
		air_jumps += 1
		return true
	
	return false
		
func is_falling() -> bool:
	return coyoute_timer <= 0 and velocity.y > 0
	
func is_jumping() -> bool:
	return velocity.y < 0
		
func fast_fall():
	if down_input:
		velocity.y += 15

func _ready() -> void:
	_state_machine.init(self)
	hurtbox.damage_taken.connect(_state_machine.on_damage_taken)
	attacker.hitbox.owner_entity = self

func _process(delta: float) -> void:
	pass
	
func ensure_rotation():
	if x_input > 0:
		_skin_node.scale.x = -1
		attacker.scale.x = -1
		hurtbox.scale.x = -1
		_standing_collision.scale.x = -1
	elif x_input < 0:
		_skin_node.scale.x = 1
		attacker.scale.x = 1
		hurtbox.scale.x = 1
		_standing_collision.scale.x = 1
	
func _physics_process(delta: float) -> void:
	jump_input = Input.is_action_just_pressed("move_jump")
	down_input = Input.is_action_pressed("move_down")
	run_input = Input.is_action_pressed("move_run")
	x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	attack_input = Input.is_action_just_pressed("weapon_attack")
	
	if Input.is_action_just_pressed("ui_text_completion_replace"):
		add_powerup(PowerupDatabase.get_item('double_jump'))
		
	if Input.is_action_just_pressed("ui_text_backspace"):
		powerups.pop_back()
		powerups_changed.emit(powerups)

	move_and_slide()
