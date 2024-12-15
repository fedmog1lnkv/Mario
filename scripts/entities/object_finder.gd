class_name ObjectFinder extends Area2D

signal on_floor_found(object: Node2D) 

signal on_floor_lost(object: Node2D)

func _on_area_entered(other):
	on_floor_found.emit(other)

func _on_area_exited(other):
	on_floor_lost.emit(other)

func _ready():
	connect("body_entered", _on_area_entered)
	connect("body_exited", _on_area_exited)
	
	for body in get_overlapping_bodies():
		_on_area_entered(body)
	
