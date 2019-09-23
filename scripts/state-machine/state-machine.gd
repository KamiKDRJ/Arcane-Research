extends Node
class_name StateMachine


onready var parent = get_parent()

var state setget ,_get_state
var state_prev setget ,_get_state_prev
var states = {}
var state_is_new = false
var state_switch = [false, '']

var run_logic = true

var sprite
var animation_ended = false
var animation_end_called = false


func _physics_process(delta):
	if state && run_logic: _execute_methods(delta)
		
## Switches to different state and end of frame
func switch(state_name: String) -> void:
	print('StateMachine - ' + state_name)
	if states.has(state_name): state_switch = [true, state_name]

## Creates a new state
func create_state(state_name: String, script_path: String):
	states[state_name] = { 'name': state_name, 'script': load(script_path).new() }
	get_parent().add_child(states[state_name].script)
	states[state_name].script.SM = self

## Sets the default state to start on
func default_state(state_name: String) -> void:
	if states.has(state_name): state = states[state_name]
	else: state = states[0]
	state_is_new = true

## Used to set animation node
func set_animation_sprite(node: Node): sprite = node


## Executes state methods
func _execute_methods(delta):
	if state_is_new: state.script.enter_state()
	state_is_new = false
	state.script.state_logic(delta)
	if _animation_check_end(): state.script.animation_end()
	if state_switch[0]: _set_state(state_switch[1])

func _animation_check_end():
	if sprite is AnimatedSprite:
		var frames = sprite.frames.get_frame_count(sprite.animation) - 1
		if sprite.frame == frames && !animation_end_called: 
			animation_end_called = true
			return true
		elif sprite.frame == 0: animation_end_called = false
		return false

func _set_state(state_name: String) -> void:
	state.script.exit_state()
	state_prev = state
	state = states[state_name]
	state_is_new = true
	state_switch = [false, '']

func _get_state(): return state.name if state else ''
func _get_state_prev(): return state_prev.name if state_prev else ''