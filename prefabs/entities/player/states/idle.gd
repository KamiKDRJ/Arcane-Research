extends State


func enter_state():
    p.Sprite.play('idle')

func state_logic(_d):
    p.movement_handler(Inputs.direction, 0)

    if Inputs.direction != Vector2.ZERO:
        var target = 'run' if p.running else 'walk'
        SM.switch(target)
    if Inputs.crouch[0]: SM.switch('crouch')

func animation_end():
	p.running = false

    