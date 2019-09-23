extends Node

var left setget ,get_left_input
var right setget ,get_right_input
var up setget ,get_up_input
var down setget ,get_down_input
var use setget ,get_use_input
var crouch setget ,get_crouch_input
var run setget ,get_run_input
var attack setget ,get_attack_input
var direction setget ,get_direction_input

func get_input_array(input: String): return [Input.is_action_just_pressed(input), Input.is_action_pressed(input), Input.is_action_just_released(input)]
func get_left_input(): return get_input_array('input_left')
func get_right_input(): return get_input_array('input_right')
func get_up_input(): return get_input_array('input_up')
func get_down_input(): return get_input_array('input_down')
func get_use_input(): return get_input_array('input_use')
func get_crouch_input(): return get_input_array('input_crouch')
func get_run_input(): return get_input_array('input_run')
func get_attack_input(): return get_input_array('input_attack')
func get_direction_input():
	var dirs = [get_left_input()[1], get_right_input()[1], get_up_input()[1], get_down_input()[1]]
	return Vector2(int(dirs[1]) - int(dirs[0]), int(dirs[3]) - int(dirs[2]))

