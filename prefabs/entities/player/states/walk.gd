extends State


func enter_state():
	root.Sprite.play('walk')

func logic(_d):
	root.movement_handler(Inputs.direction, root.walk_speed)
	root.sprite_flip(Inputs.direction.x)

	if Inputs.direction == Vector2.ZERO: stateMachine.switch('Idle')
	if root.running: stateMachine.switch('Run')
	if Inputs.crouch[0]: stateMachine.switch('Crouch-Walk')

func animation_end():
	root.running = false
