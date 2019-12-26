extends Node2D

export (NodePath) var inventory

func _physics_process(delta):
	var mpos = get_global_mouse_position()
	
#	if global_position.distance_to(mpos) < 16 * 4:
	$Area2D.global_position = mpos
	
	var objects = $Area2D.get_overlapping_bodies()
	if objects != []:
		for i in objects:
			if i.is_in_group('object'):
				if Input.is_action_just_pressed('mouse_left'):
					i.queue_free()
					get_node(inventory).add_item(Item.new('parchment'))
				return
		pass
