extends State

func enter_state():
	root.Sprite.play('walk')
	root.direction = Utils.random_direction_8()
	root.start_timer(rand_range(3, 5))

func logic(_d):
	# print('Wander')
	root.movement_handler(root.direction, root.walk_speed)
	root.sprite_flip(sign(root.direction.x))

	if root.timer_timeout:
		stateMachine.switch('Idle')

	if root.react_entered && root.react_body:
		var dir = (root.position - root.react_body.position).normalized()
		root.direction = dir
		stateMachine.switch('RunAway')

func animation_end(): pass
