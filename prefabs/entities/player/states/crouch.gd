extends State


func enter_state():
	root.Sprite.play('crouch')

func logic(_d):
	root.movement_handler(Inputs.direction, 0)

	if Inputs.direction != Vector2.ZERO: stateMachine.switch('Crouch-Walk')
	if Inputs.crouch[2]: stateMachine.switch('Idle')

func animation_end():
	root.running = false
