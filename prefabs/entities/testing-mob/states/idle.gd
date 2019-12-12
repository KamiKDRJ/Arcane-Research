extends State


func enter_state():
	root.Sprite.play('idle')
	var t = rand_range(2, 5)
	root.start_timer(t)
	print(t)
	
func logic(_d):
	root.movement_handler(Vector2.ZERO, 0)

	if root.timer_timeout:
		stateMachine.switch('Wander')
		
	if root.react_entered && root.react_body:
		var dir = (root.position - root.react_body.position).normalized()
		root.direction = dir
		stateMachine.switch('RunAway')
		

func animation_end(): pass
