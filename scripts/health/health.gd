tool
extends Node
class_name HealthController


# Signals and Exports #
signal death
signal damaged
signal healed

export (int) var value = 3 setget _set_value
export (int) var max_value = 3 setget _set_value_max
export (bool) var invincible


# Public Methods #
func heal(value: int) -> void:
	self.value += value
	self.value = clamp(self.value, 0, self.max_value)
	emit_signal('healed')

func damage(value: int) -> void:
	self.value -= value
	self.value = clamp(self.value, 0, self.max_value)
	
	emit_signal("damaged")
	if self.value <= 0: emit_signal('death')


# Private Methods #
func _set_value(new_value):
	value = new_value
	value = clamp(value, 0, 100000)
	_update_value()
	
func _set_value_max(new_value):
	max_value = new_value
	_update_value_max()

func _update_value():
	if value > max_value: max_value = value
	property_list_changed_notify()

func _update_value_max():
	if max_value < value: value = max_value
	property_list_changed_notify()
	
