class_name Slime extends CharacterBody2D

@export var health: int = 10
@export var run_speed: float = 50

@onready var hurtbox: HurtBox = $HurtBox
@onready var hitbox: HitBox = $HitBox
@onready var character_finder: CharacterFinder = $CharacterFinder
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: SlimeStateMachine = $StateMachine
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var floor_finder: ObjectFinder = $FloorFinder

@onready var dead_player: AudioStreamPlayer2D = $Dead

var powerups: Array[PowerUp] = []
var gravity_magnitude : float = 9.8
var x_input = 0

var target: Node2D = null

var floor_count = 0

func ensure_rotation():
	if x_input > 0:
		sprite.scale.x = -1
		hurtbox.scale.x = -1
		hitbox.scale.x = -1
		collision.scale.x = -1
		floor_finder.scale.x = -1
	elif x_input < 0:
		sprite.scale.x = 1
		hurtbox.scale.x = 1
		hitbox.scale.x = 1
		collision.scale.x = 1
		floor_finder.scale.x = 1

func fall():
	if not is_on_floor():
		velocity.y += gravity_magnitude
		
func run():
	velocity.x = x_input * run_speed

func _ready() -> void:
	state_machine.init(self)
	hurtbox.damage_taken.connect(take_damage)
	character_finder.on_character_found.connect(func (e): target = e)
	character_finder.on_character_lost.connect(func (e): target = null)
	
	floor_finder.on_floor_found.connect(func (e): floor_count += 1)
	floor_finder.on_floor_lost.connect(func (e): floor_count -= 1)
	
	
func take_damage(damage: int):
	state_machine.on_damage_taken(damage)
	
func _physics_process(delta: float) -> void:
	if target != null and floor_count > 0:
		x_input = sign(target.position.x - position.x)
	elif floor_count <= 0:
		x_input = 0
