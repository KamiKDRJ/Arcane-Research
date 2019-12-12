extends State


func enter_state():
	root.Sprite.play('crouch-walk')

func logic(_d):
	root.movement_handler(Inputs.direction, root.crouch_speed)
	root.sprite_flip(Inputs.direction.x)

	if Inputs.direction == Vector2.ZERO: stateMachine.switch('Crouch')
	if Inputs.crouch[2]: stateMachine.switch('Walk')

func animation_end():
	root.running = false
