extends Control

enum { INVENTORY, HOTBAR, SHOP, CRAFT }
enum LocalTypes { INVENTORY, HOTBAR, SHOP, CRAFT }

export (LocalTypes) var type
export (NodePath) var name_label
export (NodePath) var desc_label
export (NodePath) var icon_texture
export (NodePath) var amount_label
export (NodePath) var cost_icon
export (NodePath) var cost_amount

var item
var index

onready var Name = get_node(name_label)
onready var Desc = get_node(desc_label)
onready var Icon = get_node(icon_texture)
onready var Amount = get_node(amount_label)
onready var CostI = get_node(cost_icon)
onready var CostA = get_node(cost_amount)

func _ready():
	clear_item()
	update_item()
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
#	if get_parent() is Control && get_parent().type == get_parent().SHOP:
#		if !item: queue_free()

func set_item(item: Item, amount: int = 1):
	self.item = item
	self.item.data.amount = amount
	
	update_item()

func clear_item():
	if Name: Name.text = ''
	if Desc: Desc.text = ''
	if Icon: Icon.texture = null
	if Amount: Amount.text = ''
	if CostI: CostI.texture = null
	if CostA: CostA.text = ''

func update_item():
	if item:
		if Name: Name.text = str(item.data.name).capitalize()
	#	if Desc: Desc.text = item.data.desc
		if Icon: Icon.texture = load(item.data.sprite)
		if Amount: Amount.text = str(1)
	#	ItemTexture.texture = load(item.data.sprite)
	#	ItemCount.text = str(min(item.data.amount, 9999))
