extends Control


enum { INVENTORY, HOTBAR, SHOP, CRAFT }
enum LocalTypes { INVENTORY, HOTBAR, SHOP, CRAFT }
export (LocalTypes) var type

onready var children = get_children()
onready var size = get_children().size()

var left_click = false
var right_click = false
var double_click = false


## NODE METHODS ##
func _input(event):
	if event is InputEventMouseButton:
		if !_inside_bounderies(): return
		
		if event.button_index == BUTTON_LEFT && event.doubleclick: double_click = true
		else:
			var just_pressed = event.is_pressed() && !event.is_echo()
			
			if event.button_index == BUTTON_LEFT && just_pressed:
				left_click = true
				double_click = false
			else: left_click = false
			
			if event.button_index == BUTTON_RIGHT && just_pressed:
				right_click = true
				double_click = false
			else: right_click = false
					
			var slot = _get_current_slot()
			if slot != -1: _mouse_control(slot)


## PUBLIC METHODS ##
func add_item(new_item: Item, amount: int = 1):
	var children = get_children()
	for slot in children:
		if !_is_slot(slot): continue

		if !slot.item:
			slot.set_item(new_item, amount)
			break
		if slot.item && _same_name(new_item, slot.item):
			slot.item.data.amount += amount
			slot.update_item()
			break


## PRIVATE METHODS ##
func _mouse_control(index):
	if !get_parent().visible: return
	
	var slot = children[index]
	
	match type:
		INVENTORY:
			if double_click:
				double_click = false
				_double_click_inventory(slot, index)
			if left_click:
				_inventory_left_click(slot)
			if right_click:
				_inventory_right_click(slot)
		SHOP:
			if left_click || double_click:
				#  || (InvController.held_item && slot.item && _same_name(InvController.held_item, slot.item))
				if (!InvController.held_item && slot.item):
					InvController.held_item = Item.new(slot.item.data.name)
					InvController.held_item.data.amount = slot.item.data.amount
					InvController._update_held_item()
					return true

				if (InvController.held_item && slot.item) && _same_name(InvController.held_item, slot.item):
					InvController.held_item.data.amount += slot.item.data.amount
					InvController._update_held_item()
					return true

	InvController._update_held_item()

func _inventory_left_click(slot):
	if _attempt_pickup_items(slot): return
	if _attempt_store_items(slot): return
	if _attempt_stack_items(slot): return

func _inventory_right_click(slot):
	if _attempt_split_items(slot): return
	if _attempt_store_item(slot): return

func _double_click_inventory(slot, index):
	if _pickup_all(slot, index): return

func _same_name(item0, item1):
	return item0.data.name == item1.data.name

func _is_slot(child):
	return child.is_in_group('slot')

func _inside_bounderies():
	var mpos = get_global_mouse_position()
	var pos = get_parent().rect_global_position if get_parent() is Control else rect_global_position
	var size = get_parent().rect_size if get_parent() is Control else rect_size

	var x = mpos.x > pos.x && mpos.x <= pos.x + size.x
	var y = mpos.y > pos.y && mpos.y <= pos.y + size.y

	return x && y

func _get_current_slot():
	for i in range(get_children().size()):
		var mpos = get_global_mouse_position()

		var slot = get_children()[i]
		if !_is_slot(slot): break
		
		var slot_pos = slot.rect_global_position
		var slot_size = slot.rect_size

		var x = mpos.x > slot_pos.x && mpos.x < slot_pos.x + slot_size.x
		var y = mpos.y > slot_pos.y && mpos.y < slot_pos.y + slot_size.y

		if x && y: return i
	return -1

func _attempt_pickup_items(slot):
	if !InvController.held_item && slot.item:
		InvController.held_item = slot.item
		slot.clear_item()
		return true
	return false

func _attempt_store_items(slot):
	if InvController.held_item && !slot.item:
		slot.set_item(InvController.held_item, InvController.held_item.data.amount)
		InvController.held_item = null
		return true
	return false

func _attempt_stack_items(slot):
	if InvController.held_item && slot.item:
		if InvController.held_item.data.name == slot.item.data.name:
			slot.item.data.amount += InvController.held_item.data.amount
			slot.item.data.amount = int(slot.item.data.amount)
			slot.update_item()
			InvController.held_item = null
			# InvController._update_held_item()
		return true
	return false

func _attempt_split_items(slot):
	if !InvController.held_item && slot.item:
		if slot.item.data.amount == 1:
			InvController.held_item = slot.item
			# InvController._update_held_item()
			slot.clear_item()
			return true
		
		InvController.held_item = Item.new(slot.item.data.name)
		InvController.held_item.data = slot.item.data.duplicate()
		# InvController._update_held_item()
		var ini_amount = slot.item.data.amount
		
		InvController.held_item.data.amount = int(floor(ini_amount / 2))
		slot.item.data.amount = int(floor(ini_amount / 2))
		if ini_amount % 2: slot.item.data.amount += 1
		
		slot.update_item()
		
		return true
	return false

func _attempt_store_item(slot):
	if InvController.held_item: # PLACE ONE
		if slot.item: 
			if _same_name(InvController.held_item, slot.item): # PLACE ONE ON STACK
				slot.item.data.amount += 1
				InvController.held_item.data.amount -= 1
				
				slot.update_item()
				
				if InvController.held_item.data.amount <= 0:
					InvController.held_item = null
				return true

		if !slot.item:
			slot.set_item(Item.new(InvController.held_item.data.name), 1)
			InvController.held_item.data.amount -= 1
			
			if InvController.held_item.data.amount <= 0:
				# InvController.held_item.queue_free()
				InvController.held_item = null
			return true
	return false

func _pickup_all(slot, index):
	if InvController.held_item:
		for j in range(size):
			var check_slot = children[j]
			if !_is_slot(check_slot): continue

			if index != j && check_slot.item && _same_name(InvController.held_item, check_slot.item):
				InvController.held_item.data.amount += check_slot.item.data.amount
				check_slot.clear_item()
		return true
	return false
