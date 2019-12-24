extends Control

onready var sc0 = $ScrollContainer2/GridContainer
onready var sc1 = $ScrollContainer/HBoxContainer

func _ready():
	for i in range(2):
		var item = Item.new('ring-blank')
		sc0.add_item(item, 10)
	for i in range(2):
		var item = Item.new('ring-blank')
		sc1.add_item(item, 5)
	for i in range(2):
		var item = Item.new('ring-blank')
		sc0.add_item(item, 5)
	
