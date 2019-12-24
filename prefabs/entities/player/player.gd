extends EntityBase


## Nodes ## 
onready var Cursor = Globals.Cursor
onready var CursorDirection = $CursorDirection
onready var StateMachine = $StateMachine
onready var Inv = $Inventory


## Properties ##
var crouch_speed = 40
var walk_speed = 60
var run_speed = 120
var running = false

var entity_entered = false
var item_entered = false
var item = null
var entity = null


## Node Methods ##
func _init():
	Globals.Player = self

func _physics_process(_d):
	_world_interaction()
	if Inputs.run[0]: running = true if !running else false 
	_cursor_control()
	# Debug
	if Input.is_action_pressed("input_crouch"):
		if Input.is_action_just_pressed("r"):
			get_tree().change_scene("res://main.tscn")

## Private Methods ##
func _cursor_control():
	if Cursor: CursorDirection.rotation = get_global_mouse_position().angle_to_point(global_position)

func _world_interaction():
	var overlapping = $WorldInteraction.get_overlapping_areas()
	if overlapping != []:
		for i in overlapping:
			if i.is_in_group('item'):
				item_entered = true
				item = i
				break
			else:
				item_entered = false
				item = null
				
	overlapping = $WorldInteraction.get_overlapping_bodies()
	if overlapping != []:
		for i in overlapping:
			if i.is_in_group('entity'):
				print('test')
				entity_entered = true
				entity = i
		

	if item_entered && item:
		Inv.add_item(Item.new(item.data.name), item.count)
		item.queue_free()
		item_entered = false
		item = null
#		StateMachine.switch('Pickup')
		# NOTIFY: Inventory Full
#
#		if entity_entered && entity:
#			entity.queue_free()
#			entity_entered = false
#			entity = null
#			StateMachine.switch('Pickup')
			
		


## Signals ##
#func _on_area_entered(area):
#	if area.is_in_group('item'):
#		item_entered = true
#		item = area
#func _on_area_exited(area):
#	if area.is_in_group('item'):
#		item_entered = false 
#		item = null
