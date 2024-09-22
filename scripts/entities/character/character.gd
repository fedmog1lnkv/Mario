class_name Character
extends CharacterBody2D

@export var walk_speed = 50.0
@export var jump_force = 300.0
var gravity_magnitude : float = 9.8


var x_input = 0.0
var jump_input = false

@onready var _standing_collision: CollisionShape2D = get_node("StandingShape")
@onready var _standing_sprite: Sprite2D = get_node("StandingSprite")

var crouch_input = false
@onready var _crouched_collision: CollisionShape2D = get_node("CrouchShape")
@onready var _crouched_sprite: Sprite2D = get_node("CrouchSprite")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	crouch_input = Input.is_action_pressed("ui_down")
	
func _physics_process(delta: float) -> void:
	jump_input = Input.is_action_just_pressed("ui_accept")
	
	if crouch_input and is_on_floor():
		_standing_collision.disabled = true
		_standing_sprite.visible = false
		
		_crouched_collision.disabled = false
		_crouched_sprite.visible = true
	else:
		_standing_collision.disabled = false
		_standing_sprite.visible = true
		
		_crouched_collision.disabled = true
		_crouched_sprite.visible = false
	
	if is_on_floor() and jump_input:
		velocity.y = -jump_force
	elif not is_on_floor():
		velocity.y += gravity_magnitude
	velocity.x = x_input * walk_speed
	move_and_slide()
