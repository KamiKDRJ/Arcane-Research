extends EntityBase


## Nodes ## 
onready var Cursor = Globals.Cursor
onready var CursorDirection = $CursorDirection
onready var StateMachine = $StateMachine
onready var Inv = Inventory.new(20)


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
	if Cursor: CursorDirection.rotation = Cursor.position.angle_to_point(CursorDirection.global_position)
	else: CursorDirection.visible = false

## Private Methods ##
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
		

	if Inputs.use[0]:
		if item_entered && item:
			item.count = inventory.add(item.data.name, item.count)
			if item.count == 0:
				item.queue_free()
				item_entered = false
				item = null
				StateMachine.switch('Pickup')
				# NOTIFY: Inventory Full
		if entity_entered && entity:
			entity.queue_free()
			entity_entered = false
			entity = null
			StateMachine.switch('Pickup')
			
		


## Signals ##
#func _on_area_entered(area):
#	if area.is_in_group('item'):
#		item_entered = true
#		item = area
#func _on_area_exited(area):
#	if area.is_in_group('item'):
#		item_entered = false 
#		item = null
