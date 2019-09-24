extends Node

func get_scene_root() -> Node:
	return get_tree().get_root()

func find_node_in_scene(node_name: String) -> Node:
	return get_scene_root().find_node(node_name, true, false)

func int2bool(value: int) -> bool:
	return true if value > 0 else false

func create_timer(target: Node, method: String, wait_time: int = 1, start: bool = false, one_shot: bool = true) -> Node:
	var timer = Timer.new()

	timer.wait_time = wait_time
	timer.one_shot = one_shot
	timer.connect('timeout', target, method)
	if start: timer.start()

	add_child(timer)
	return timer

func random_direction() -> Vector2:
	randomize()

	var directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
	var rnd = randi() % 4

	return directions[rnd]

func random_direction_8() -> Vector2:
	randomize()
	var new = Vector2(0, 0)
	while new == Vector2(0, 0): new = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	return new