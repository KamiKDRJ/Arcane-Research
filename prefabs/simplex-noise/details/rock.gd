extends RigidBody2D

onready var start_position = position

func _process(delta):
	if position != start_position:
		position = lerp(position, start_position, .1)
