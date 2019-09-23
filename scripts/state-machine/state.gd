extends Node2D
class_name State

onready var p = get_parent()
var SM

func enter_state(): pass
func state_logic(delta): pass
func exit_state(): pass
func animation_end(): pass