extends EntityBase
class_name EntityMobBase


## Properties ##
onready var AwareCircle = $AwareCircle
onready var ReactCircle = $ReactCircle

var aware_entered = false
var react_entered = false
var aware_body
var react_body
var react_to = ['Crouch-Walk', 'Crouch', 'Idle', 'Pickup']


## Node Methods ##
func _ready():
	AwareCircle.connect('body_entered', self, '_on_aware_entered')
	AwareCircle.connect('body_exited', self, '_on_aware_exited')
	ReactCircle.connect('body_entered', self, '_on_react_entered')
	ReactCircle.connect('body_exited', self, '_on_react_exited')

func _physics_process(delta):
	react_check()


## Private Methods ##
func react_check():
	if react_body:
		if !react_to.has(react_body.StateMachine.state.name): react_entered = true
		else: react_entered = false


## Signal Methods ##
func _on_aware_entered(body): 
	aware_entered = true
	aware_body = body

func _on_aware_exited(body):
	aware_entered = false
	aware_body = null

func _on_react_entered(body):
	react_body = body
	react_check()

func _on_react_exited(body):
	react_entered = false
	react_body = null
