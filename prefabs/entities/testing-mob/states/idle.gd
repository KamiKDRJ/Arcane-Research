extends State


func enter_state():
	p.Sprite.play('idle')
	p.start_timer((randi() % 50 + 100) / 100)

func state_logic(_d):
	p.movement_handler(Vector2.ZERO, 0)

	if p.timer_timeout:
		SM.switch('wander')

func animation_end(): pass