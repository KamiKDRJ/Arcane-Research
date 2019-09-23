extends State


func enter_state():
    p.Sprite.play('walk')

func state_logic(_d):
    p.movement_handler(Inputs.direction, p.walk_speed)
    p.sprite_flip(Inputs.direction.x)

    if Inputs.direction == Vector2.ZERO: SM.switch('idle')
    if p.running: SM.switch('run')
    if Inputs.crouch[0]: SM.switch('crouch-walk')

func animation_end():
    p.running = false
