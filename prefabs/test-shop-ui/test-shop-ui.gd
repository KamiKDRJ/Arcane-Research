extends Control

#
onready var shop = $TabContainer/Inventory/GridContainer
#
func _ready():
	shop.add_item(Item.new('parchment'))
