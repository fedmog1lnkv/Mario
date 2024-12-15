class_name HitBox extends Area2D

@onready var _collision: CollisionShape2D = get_node("CollisionShape2D")

@export var damage: int = 0

var owner_entity: Node2D = null

func disable():
	_collision.set_deferred("disabled", true)
  
func enable():
	_collision.set_deferred("disabled", false)
