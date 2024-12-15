extends Node

@export var loot: PowerUp

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var hurtbox: HurtBox= $HurtBox
@onready var sprite: Sprite2D = $Sprite2D

var is_dead = false

func _ready() -> void:
	hurtbox.damage_taken_direct.connect(
		func (entity, damage):
			if not is_dead:
				sprite.visible = false
				collision.set_deferred('disabled', true)
				is_dead = true
				if loot != null:
					EventBus.loot_gained.emit(entity, loot)
	)
