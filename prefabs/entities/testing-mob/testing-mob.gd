extends EntityMobBase

## Nodes ##
onready var Timer = $Timer

## Properties ##
var walk_speed = 30
var run_speed = 110
var wander = false
var timer_timeout = false
var react_state
enum States { Wander, RunAway, RunTowards }


## Node Methods ##
func _ready():
	_init_state_machine()
	react_state = States.Wander

func _physics_process(_d): pass

## Public Methods ##
func start_timer(wait_time: int, one_shot: bool = true):
	timer_timeout = false
	Timer.one_shot = one_shot
	Timer.start(wait_time)
	

## Private Methods ##
func _init_state_machine():
	var path = 'res://prefabs/entities/testing-mob/states/'
	SM.create_state('idle', path + 'idle.gd')
	SM.create_state('wander', path + 'wander.gd')
	SM.default_state('idle')

func _on_timer_timeout(): timer_timeout = true