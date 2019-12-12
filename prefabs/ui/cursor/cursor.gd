extends Node2D


# Signals and Nodes #
signal left_press
signal right_press
onready var fadeTimer = $Timer


# Properties #
var fade = false


# Node Methods #
func _init():
	Globals.Cursor = self

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	fadeTimer.connect("timeout", self, '_on_timer_timeout')

func _physics_process(_d):
	_inputs()
	_move_fade_logic()
	_fade_control()


# Private Methods #
func _move_fade_logic():
	var prev_position = global_position
	global_position = get_global_mouse_position()
	
	if global_position == prev_position:
		if fadeTimer.is_stopped():
			fadeTimer.start(2)
	else:
		if !fadeTimer.is_stopped():
			fadeTimer.stop()
			fade = false

func _fade_control():
	var target = .25 if fade else 1
	if modulate.a != target:
		modulate = lerp(modulate, Color(1, 1, 1, target), .05)

func _inputs():
	if Input.is_action_just_pressed("mouse_left"): emit_signal("left_press")
	if Input.is_action_just_pressed("mouse_right"): emit_signal("right_press")


# Signal Methods #
func _on_timer_timeout(): fade = true
