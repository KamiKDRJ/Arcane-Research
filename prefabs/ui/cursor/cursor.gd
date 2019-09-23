extends Sprite

onready var Timer = Utils.create_timer(self, '_on_timer_timeout', 2)
var fade = false

func _init():
	Globals.Cursor = self

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	var old_pos = global_position
	global_position = get_global_mouse_position()
	
	if old_pos == global_position:
		if Timer.is_stopped():
			Timer.start()
	elif !Timer.is_stopped():
		fade = false
		Timer.stop()
	
	var target = .25 if fade else 1
	if modulate.a != target:
		modulate = lerp(modulate, Color(1, 1, 1, target), .05)

func _on_timer_timeout(): fade = true
