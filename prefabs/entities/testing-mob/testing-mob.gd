extends EntityMobBase

## Nodes ##
onready var Timer = Utils.create_timer(self, '_on_timer_timeout')

## Properties ##
var walk_speed = 30
var run_speed = 75
var wander = false
var timer_timeout = false
var run_direction = Vector2()


## Node Methods ##
func _ready():
	add_to_group('entity')

## Private Methods ##
func start_timer(wait_time: int, one_shot: bool = true):
	timer_timeout = false
	Timer.one_shot = one_shot
	Timer.start(wait_time)


## Signal Methods ##
func _on_timer_timeout(): timer_timeout = true
