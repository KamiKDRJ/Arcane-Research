tool
extends Node
class_name Health

signal hasDied

export (int) var value = 3 setget _set_value
export (int) var max_value = 3 setget _set_value_max
export (bool) var invincible


func heal(value: int) -> void:
    self.value += value
    self.value = clamp(self.value, 0, self.max_value)

func damage(value: int) -> void:
    self.value -= value
    self.value = clamp(self.value, 0, self.max_value)

    if self.value <= 0: emit_signal('hasDied')


func _set_value(new_value):
	value = new_value
	value = clamp(value, 0, 100000)
	
	_update_exports()
	
func _set_value_max(new_value):
	max_value = new_value
	_update_exports()

func _update_exports():
	if value > max_value: max_value = value
	property_list_changed_notify()
