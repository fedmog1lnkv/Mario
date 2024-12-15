class_name HurtBox extends Area2D

signal damage_taken(damage: int)

signal damage_taken_direct(owner_entity: Node2D, damage: int)

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Node2D) -> void:
	if hitbox != null and hitbox is HitBox and hitbox.owner != owner:
		damage_taken.emit(hitbox.damage)
		damage_taken_direct.emit(hitbox.owner_entity, hitbox.damage)
