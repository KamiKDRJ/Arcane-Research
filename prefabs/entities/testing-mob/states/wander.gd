extends State


func enter_state():
	p.Sprite.play('walk')
	p.direction = Utils.random_direction_8()
	p.start_timer((randi() % 20 + 30) / 10)

func state_logic(_d):
	p.movement_handler(p.direction, p.walk_speed)
	p.sprite_flip(sign(p.direction.x))

	if p.timer_timeout:
		SM.switch('idle')

func animation_end(): pass