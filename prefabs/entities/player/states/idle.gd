extends State

func enter_state():
	root.Sprite.play('idle')

func logic(_d):
	root.movement_handler(Inputs.direction, 0)

	if Inputs.direction != Vector2.ZERO:
		var target = 'Run' if root.running else 'Walk'
		stateMachine.switch(target)
	if Inputs.crouch[0]: stateMachine.switch('Crouch')

func animation_end():
	root.running = false
