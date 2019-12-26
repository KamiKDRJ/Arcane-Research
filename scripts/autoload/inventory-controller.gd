extends Node2D

var held_item
var test = preload('res://prefabs/inventory/slot.tscn')
var n = test.instance()

func _ready():
	add_child(n)
	n.texture = null
	z_index = 100
	
	_update_held_item()

func _input(event):
	if held_item && event is InputEventMouseMotion:
		held_item.rect_global_position = get_global_mouse_position()
		n.rect_global_position = get_global_mouse_position()

func _update_held_item():
	if held_item:
		held_item.rect_global_position = get_global_mouse_position()

		n.visible = true
		n.set_item(held_item, held_item.data.amount)
		n.rect_global_position = get_global_mouse_position()
	else:
		n.clear_item()
		n.visible = false
