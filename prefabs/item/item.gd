extends Area2D

onready var sprite = $Sprite
export (String) var item_name = ''
var count = 1
var data = []
var player_entered = false

func _ready():
	update_data(item_name)
	
	connect('body_entered', self, '_on_body_entered')
	connect('body_exited', self, '_on_body_exited')
	add_to_group('item')

func _process(delta):
	var Player = Globals.Player
	if Player:
		if global_position.distance_to(Player.global_position) < 100:
			global_position += global_position.direction_to(Player.global_position) * 2
	if player_entered: # Show pickup overlay
		pass

func update_data(item_name: String):
	data = ItemDatabase.find_item(item_name)
	if data.has('group') && data.group != '': add_to_group(data.group)
	if data.has('sprite') && data.sprite != '': sprite.texture = load(data.sprite)


func _on_body_entered(body): player_entered = body.name == 'Player'
func _on_body_exited(body): player_entered = !body.name == 'Player'
