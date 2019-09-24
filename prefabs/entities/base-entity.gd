extends KinematicBody2D
class_name EntityBase

onready var Sprite = $AnimatedSprite
onready var Health = $Health
onready var drops = Inventory.new(10)
onready var inventory = Inventory.new(10)
onready var SM = StateMachine.new()

var velocity = Vector2()
var direction = Vector2.ZERO

func _ready():
	add_child(SM)
	SM.set_animation_sprite(Sprite)

func sprite_flip(direction: int) -> void:
	if direction != 0: Sprite.flip_h = true if direction == -1 else false

func movement_handler(direction: Vector2, speed: float) -> void:
	if direction.x != 0 && direction.y != 0: speed *= .8
	velocity = lerp(velocity, direction * speed, .2)
	velocity = move_and_slide(velocity)

func death(): pass
