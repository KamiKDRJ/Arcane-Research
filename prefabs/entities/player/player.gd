extends EntityBase


## Nodes ## 
onready var Cursor = Globals.Cursor
onready var CursorDirection = $CursorDirection


## Properties ##
var crouch_speed = 40
var walk_speed = 60
var run_speed = 120
var running = false

var item_entered = false
var item = null


## Node Methods ##
func _init():
	Globals.Player = self

func _ready():
	_init_state_machine()
	print(Sprite.animation)
	
func _physics_process(_d):
	_world_interaction()
	if Inputs.run[0]: running = true if !running else false 
	CursorDirection.rotation = Cursor.position.angle_to_point(CursorDirection.global_position)
	

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
		

	if item_entered && item:
		if Inputs.use[0]:
			item.count = inventory.add(item.data.name, item.count)
			if item.count == 0:
				item.queue_free()
				SM.switch('pickup')
				item_entered = false
				item = null
				return
			# NOTIFY: Inventory Full

func _init_state_machine():
	var path = 'res://prefabs/entities/player/states/'
	SM.create_state('idle', path + 'idle.gd')
	SM.create_state('walk', path + 'walk.gd')
	SM.create_state('run', path + 'run.gd')
	SM.create_state('crouch', path + 'crouch.gd')
	SM.create_state('crouch-walk', path + 'crouch-walk.gd')
	SM.create_state('pickup', path + 'pickup.gd')
	SM.default_state('idle')


## Signals ##
func _on_area_entered(area):
	if area.is_in_group('item'):
		item_entered = true
		item = area
func _on_area_exited(area):
	if area.is_in_group('item'):
		item_entered = false 
		item = null
