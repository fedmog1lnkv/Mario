class_name CharacterFinder extends Area2D

signal on_character_found(character: Node2D) 

signal on_character_lost(character: Node2D)

func _on_area_entered(other):
	if other != null and other is HurtBox and other.owner is Character:
		on_character_found.emit(other.owner)

func _on_area_exited(other):
	on_character_lost.emit(other.owner)

func _ready():
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
