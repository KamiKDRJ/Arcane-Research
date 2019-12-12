extends State

func enter_state():
	root.Sprite.play('run')
	root.start_timer(rand_range(5, 9))

func logic(_d):
	# print('Wander')
	root.movement_handler(root.direction, root.run_speed)
	root.sprite_flip(sign(root.direction.x))

	if root.timer_timeout:
		stateMachine.switch('Idle')

func animation_end(): pass
