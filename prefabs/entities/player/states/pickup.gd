extends State


func enter_state():
	root.Sprite.play('use-item')

func logic(_d):
	root.movement_handler(Inputs.direction, 0)

func animation_end():
	stateMachine.switch(stateMachine.state_prev)
	# stateMachine.switch('Idle')
