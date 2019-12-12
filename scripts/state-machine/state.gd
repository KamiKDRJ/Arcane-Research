extends Node
class_name State

onready var stateMachine = get_parent()
onready var root = stateMachine.get_parent()

func enter_state(): pass
func logic(delta): pass
func exit_state(): pass
func animation_end(): pass
