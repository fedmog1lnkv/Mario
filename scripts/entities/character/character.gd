class_name Character
extends CharacterBody2D

@export var walk_speed = 50.0
@export var run_speed = 75.0
@export var jump_force = 300.0
var gravity_magnitude : float = 9.8

var x_input = 0.0
var jump_input = false
var down_input = false
var run_input = false

@onready var _standing_collision: CollisionShape2D = get_node("Shape")
@onready var _standing_sprite: AnimatedSprite2D = get_node("Sprite")

@onready var _state_machine: CharacterStateMachine = get_node("StateMachine")

func animate(name: String):
	_standing_sprite.play(name)
	
func walk():
	velocity.x = x_input * walk_speed
	
func run():
	velocity.x = x_input * run_speed
	
func fall():
	if not is_on_floor():
		velocity.y += gravity_magnitude
		
func jump() -> bool:
	if is_on_floor() and jump_input:
		velocity.y = -jump_force
		return true
	return false
		
func is_falling() -> bool:
	return velocity.y > 0
	
func is_jumping() -> bool:
	return velocity.y < 0
		
func fast_fall():
	if down_input:
		velocity.y += 15

func _ready() -> void:
	_state_machine.init(self)

func _process(delta: float) -> void:
	pass
	
func ensure_rotation():
	if x_input > 0:
		_standing_sprite.scale.x = -1
	elif x_input < 0:
		_standing_sprite.scale.x = 1
	
func _physics_process(delta: float) -> void:
	jump_input = Input.is_action_just_pressed("move_jump")
	down_input = Input.is_action_pressed("move_down")
	run_input = Input.is_action_pressed("move_run")
	x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	

	move_and_slide()
