extends State


func enter_state():
    p.Sprite.play('walk')

func state_logic(_d):
    p.movement_handler(p.direction, p.walk_speed)
    p.sprite_flip(sign(p.direction.x))

func animation_end(): pass
