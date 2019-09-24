extends EntityBase
class_name EntityMobBase

onready var AwareCircle = $AwareCircle
onready var ReactCircle = $ReactCircle

var aware_entered = false
var react_entered = false
var aware_body
var react_body

func _ready():
	AwareCircle.connect('body_entered', self, '_on_aware_entered')
	AwareCircle.connect('body_exited', self, '_on_aware_exited')
	ReactCircle.connect('body_entered', self, '_on_react_entered')
	ReactCircle.connect('body_exited', self, '_on_react_exited')

#func _draw():
#	draw_circle(Vector2.ZERO, AwareCircle.get_node("CollisionShape2D").shape.radius, Color(1, 1, 1, .1))
#	draw_circle(Vector2.ZERO, ReactCircle.get_node("CollisionShape2D").shape.radius, Color(1, 1, 1, .1))



# Only reacts to player. May need to change that
func _on_aware_entered(body): 
	if body.name == 'Player':
		aware_entered = true
		aware_body = body
func _on_aware_exited(body):
	if body.name == 'Player':
		aware_entered = false
		aware_body = null
func _on_react_entered(body):
	if body.name == 'Player':
		react_entered = true
		react_body = body
func _on_react_exited(body):
	if body.name == 'Player':
		react_entered = false
		react_body = null
