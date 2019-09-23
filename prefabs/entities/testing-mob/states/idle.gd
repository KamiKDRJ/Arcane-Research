extends State


func enter_state():
	p.Sprite.play('idle')

func state_logic(_d):
	p.movement_handler(Vector2.ZERO, 0)

func animation_end(): pass

	