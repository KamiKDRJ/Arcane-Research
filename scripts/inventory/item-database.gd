extends Node

var default = { 'name': 'default', 'max_stack': 0, 'sprite': '', 'group': 'none', 'action': 'none' }
var data = [
	{ 
		'name': 'ring-blank',
		'max_stack': 1,
		'sprite': 'res://assets/items/Item__40.png',
	},
	{
		'name': 'necklace-skull',
		'max_stack': 1,
		'sprite': 'res://assets/items/Item__35.png',
	},
	{
		'name': 'parchment',
		'max_stack': 1,
		'sprite': 'res://assets/items/Item__38.png',
	},
]

func find_item(item_name: String) -> Dictionary:
	var item
	for i in data: if item_name == i.name: item = i
	
	if item: return _populate(item)
	else: return _populate(get_random_item())

func get_random_item() -> Dictionary:
	randomize()
	var rand = data[randi() % data.size()]
	return rand

func _populate(item):
	if !item.has('name'): item['name'] = default.name
	if !item.has('max_stack'): item['max_stack'] = default.max_stack
	if !item.has('sprite'): item['sprite'] = default.sprite
	if !item.has('group'): item['group'] = default.group
	if !item.has('action'): item['action'] = default.action
	return item

