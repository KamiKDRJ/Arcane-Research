extends State


func enter_state():
	root.Sprite.play('run')

func logic(_d):
	root.movement_handler(Inputs.direction, root.run_speed)
	root.sprite_flip(Inputs.direction.x)

	if Inputs.direction == Vector2.ZERO: stateMachine.switch('Idle')
	if !root.running: stateMachine.switch('Walk')
	if Inputs.crouch[0]: stateMachine.switch('Crouch-Walk')

