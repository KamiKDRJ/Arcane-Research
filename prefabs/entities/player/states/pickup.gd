extends State


func enter_state():
    p.Sprite.play('use-item')

func state_logic(_d):
    p.movement_handler(Inputs.direction, 0)

func animation_end():
	SM.switch(SM.state_prev)

    