extends Node
class_name StateMachine

var states = []
var state: State
var state_prev: State
var state_is_new = false
var run_logic = true
var anims
var anim_end_called = false

func _ready():
	for i in get_children():
		states.append(i)
	state = states[0]
	state_is_new = true
	
	if get_parent().has_node("AnimatedSprite"):
		anims = get_parent().get_node("AnimatedSprite")
	
func _physics_process(delta):
	if !run_logic || !state: return

	if state_is_new:
		if state_prev: state_prev.exit_state()
		state.enter_state()
		state_is_new = false
	state.logic(delta)
	
	
	if anims:
		if !anim_end_called:
			if anims.frame == anims.frames.get_frame_count(anims.animation) - 1:
				state.animation_end()
				anim_end_called = true
		else:
			if anims.frame == 0:
				anim_end_called = false
	
#	if $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count($AnimatedSprite.animation) - 1:
#		print('test')

func switch(state_name: String):
	for i in states:
		if i.name == state_name:
			state_prev = state
			state = i
			state_is_new = true

	
