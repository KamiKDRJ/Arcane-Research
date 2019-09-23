extends State


func enter_state():
    p.Sprite.play('crouch-walk')

func state_logic(_d):
    p.movement_handler(Inputs.direction, p.crouch_speed)
    p.sprite_flip(Inputs.direction.x)

    if Inputs.direction == Vector2.ZERO: SM.switch('crouch')
    if Inputs.crouch[2]: SM.switch('walk')

func animation_end():
    p.running = false
