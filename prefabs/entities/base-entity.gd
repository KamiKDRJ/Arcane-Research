extends KinematicBody2D
class_name EntityBase


## Nodes ##
onready var Sprite = $AnimatedSprite
onready var Health = $HealthContoller
onready var drops = Inventory.new(10)
onready var inventory = Inventory.new(10)


## Properties ##
var velocity = Vector2()
var direction = Vector2.ZERO


## Node Methods ##
func _ready():
	Health.connect('damaged', self, '_on_damaged')
	Health.connect('healed', self, '_on_healed')
	Health.connect('death', self, '_on_death')


## Public Methods ##
func sprite_flip(direction: int) -> void:
	if direction != 0: Sprite.flip_h = true if direction == -1 else false

func movement_handler(direction: Vector2, speed: float) -> void:
	if direction.x != 0 && direction.y != 0: speed *= .8
	velocity = lerp(velocity, direction * speed, .2)
	velocity = move_and_slide(velocity)


## Signal Methods ##
func _on_damaged() -> void: pass
func _on_healed() -> void: pass
func _on_death() -> void: pass
		
