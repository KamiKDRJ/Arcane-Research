extends Node
class_name Inventory

var data: Array = []
var data_size: int
export (int) var max_slots

func _init(slots: int) -> void:
	max_slots = slots

	for slot in max_slots: data.append({'name': '', 'count': 0, 'sprite': '', 'desc': ''})
	data_size = data.size() - 1

func add(item_name: String, count: int = 1) -> int:
	if count == 0: return 0

	var exists = false
	var added = 0
	var item = ItemDatabase.find_item(item_name)

	for i in data: if i.name == item.name: exists = true

	# FIX: Loop automatically add to first free slot it finds and not to existing slots
	for num in count:
		for slot in data:
			if exists && slot.name == item.name:
				if slot.count < item.max_stack || item.max_stack == 0:
					slot.count += 1
					added += 1
					break
				continue
			elif slot.name == '':
				slot.name = item.name
				slot.sprite = item.sprite
				slot.count = 1
				exists = true
				added += 1
				break

	return 0 if added == count else count - added

func remove(item_name: String, count: int) -> int:
	if get_item_count(name) < count: return 0

	for num in count:
		for slot in range(data_size):
			var cur_slot = data[data_size - slot]
			if cur_slot.name == name && cur_slot.count > 0:
				cur_slot.count -= 1
				break

	clear_empty()
	return count


func clear_empty() -> void:
	for i in range(data.size()): if data[i].count <= 0: data[i] = {'name': '', 'count': 0, 'sprite': '', 'desc': ''}

func get_item_count(item_name: String) -> int:
	var total = 0
	for slot in data: if slot.name == item_name: total += slot.count
	return total
