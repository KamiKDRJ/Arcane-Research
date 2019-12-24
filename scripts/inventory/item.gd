extends TextureRect
class_name Item

enum {
	NONE,
	ARMOUR,
	WEAPON,
	FOOD,
}

var data = {
# 	'id': '',
# 	'icon': '',
# 	'attributes': {
# 		'amount': 1,
# 		'maxstack': 0,
# 		'type': NONE,
# 		# examples
# #		'strength': 2, # +2
# #		'health': -4, # -4
# 	}
}

func _init(id: String):
	data = ItemDatabase.find_item(id)
	texture = load(data.sprite)
	
	mouse_filter = Control.MOUSE_FILTER_IGNORE
