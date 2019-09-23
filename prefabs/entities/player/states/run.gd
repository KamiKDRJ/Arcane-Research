extends State


func enter_state():
    p.Sprite.play('run')

func state_logic(_d):
    p.movement_handler(Inputs.direction, p.run_speed)
    p.sprite_flip(Inputs.direction.x)

    if Inputs.direction == Vector2.ZERO: SM.switch('idle')
    if !p.running: SM.switch('walk')
    if Inputs.crouch[0]: SM.switch('crouch-walk')

