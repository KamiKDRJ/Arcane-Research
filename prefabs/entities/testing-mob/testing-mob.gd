extends EntityMobBase

var walk_speed = 40
var run_speed = 110
var wander = false
var walk_state
enum States { Wander, RunAway, RunTowards }

func _ready():
	_init_state_machine()

func _physics_process(_d):
	# if aware_entered:
	# 	var body_state = aware_body.SM.state
	# 	var state_check = ['idle', 'crouch', 'crouch-walk']
	# 	if !state_check.has(body_state):
	# 		var dir = (position - aware_body.position).normalized()
	# 		direction = dir
	# 		SM.switch('run')
	# 		walk_state = States.RunAway
	# 	else:
	# 		if running_away && !timer_started:
	# 			timer_started = true
	# 			start_timer(.5)
	# 		if Timer.is_stopped():
	# 			walk_state = States.Wander
	# 			timer_started = false
	# 			SM.switch('idle')
	
	pass
				


func _init_state_machine():
	var path = 'res://prefabs/entities/testing-mob/states/'
	SM.create_state('idle', path + 'idle.gd')
	SM.create_state('walk', path + 'walk.gd')
	SM.create_state('run', path + 'run.gd')
	SM.default_state('idle')