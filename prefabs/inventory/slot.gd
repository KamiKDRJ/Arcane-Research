extends TextureRect
class_name ItemSlot

enum { INVENTORY, HOTBAR, SHOP, CRAFT }

onready var ItemTexture = $Item
onready var ItemCount = $Amount
var item = null
var type
var index


func init(index):
	self.index = index

func _ready():
	ItemCount.text = ''
	ItemTexture.texture = null
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func set_item(item: Item, amount: int = 1):
	self.item = item
	self.item.data.amount = amount
	
	update_item()

func clear_item():
	ItemTexture.texture = null
	ItemCount.text = ''
	item = null

func update_item():
	ItemTexture.texture = load(item.data.sprite)
	ItemCount.text = str(min(item.data.amount, 9999))
