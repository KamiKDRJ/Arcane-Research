extends State


func enter_state():
    p.Sprite.play('crouch')

func state_logic(_d):
    p.movement_handler(Inputs.direction, 0)

    if Inputs.direction != Vector2.ZERO: SM.switch('crouch-walk')
    if Inputs.crouch[2]: SM.switch('idle')

func animation_end():
    p.running = false
