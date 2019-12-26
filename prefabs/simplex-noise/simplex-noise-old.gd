extends Node2D

enum TILE { WATER, SAND, GRASS }
onready var Tree = preload("res://prefabs/trees/tree.tscn")
onready var Map = $TileMap

export (int) var width = 64
export (int) var height = 64
export (NodePath) var node
export (NodePath) var ysort
var tile_size = 16
var speed = 2
var offset: Vector2 = Vector2.ZERO
var old = Vector2.ZERO

var chunks = {}
# "x,y": {
# 	'tiles': 2d array
#	'details': 2d array
# }

var saved_chunks = []
var chunk_size = 16
var render_width = 4
var render_height = 4

func _ready():
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 100
	noise.persistence = .8
	
	_refresh(true)

func _refresh(b: bool = false):
	if b:
		randomize()
		noise.seed = randi()
		noise2.seed = randi()
	
	$TileMap.clear()
	$TileMap2.clear()
	
	for i in range(render_width):
		for j in range(render_height):
			_create_new_chunk(i - (render_width / 2), j - (render_height / 2))
		
	_clear_chunk(-1, 0)
	_clear_chunk(0, 0)


func _create_new_chunk(x, y):
	var new_tiles = Utils.create_2d_array(chunk_size, chunk_size)
	var new_details = Utils.create_2d_array(chunk_size, chunk_size)
	
	var nx = x * chunk_size
	var ny = y * chunk_size
	
	for i in range(chunk_size):
		for j in range(chunk_size):
			var type = _get_tile_type(nx + i, ny + j)
			_set_tile(nx + i, ny + j,  type)
			Map.update_bitmask_area(Vector2(nx + i, ny + j))
			
			if type == TILE.GRASS:
				var n = randi() % 5
				if randi() % 40 == 0:
					$TileMap2.set_cell(nx + i, ny + j,  n)


func _load_chunk(x, y):
	var c_name = str(x) + ',' + str(y)
	var nx = x * chunk_size
	var ny = y * chunk_size
	if saved_chunks.has(c_name):
		var chunk = chunks[c_name]
		for i in range(chunk_size):
			for j in range(chunk_size):
				var type = chunk.tiles[i][j]
				Map.set_cell(nx + i, nx + j, type)

func _clear_chunk(x, y):
	var new_tiles = Utils.create_2d_array(chunk_size, chunk_size)
	var new_details = Utils.create_2d_array(chunk_size, chunk_size)

	var nx = x * chunk_size
	var ny = y * chunk_size
	
	for i in range(chunk_size):
		for j in range(chunk_size):
			new_tiles[i][j] = _get_tile_type(nx + i, ny + j)
			new_details[i][j] = $TileMap2.get_cell(nx + i, ny + j)

			Map.set_cell(nx + i, ny + j, -1)
			$TileMap2.set_cell(nx + i, ny + j, -1)

	var c_name = str(x) + ',' + str(y)
	chunks[c_name] = {
		'tiles': new_tiles,
		'details': new_details,
	}
	
	saved_chunks.append(c_name)

	print(saved_chunks)

var noise = OpenSimplexNoise.new()
var noise2 = OpenSimplexNoise.new()

func _physics_process(delta):
	if !node.is_empty():
		var n = get_node(node)
		
		var a = (n.global_position.snapped(Vector2(16, 16)) / (render_width * 16))
		var clear
		var pop
		if old.x != a.x:
			var dir = sign(a.x - old.x)
			old.x = a.x
				
			clear = a.x - 2 if dir == 1 else a.x + width - 1
			pop = a.x + width - 2 if dir == 1 else a.x -1
			
			_clear_column(clear, a.y - 1)
			_populate_column(pop, a.y - 1)
			
		elif old.y != a.y:
			var dir = sign(a.y - old.y)
			old.y = a.y
			
			clear = a.y - 2 if dir == 1 else a.y + height - 1
			pop = a.y + height - 2 if dir == 1 else a.y - 1
			
			_clear_row(clear, a.x - 1)
			_populate_row(pop, a.x - 1)
			
			
func _clear_column(column: int, y):
	for i in range(height):
		_set_tile(column, i + y, -1)
		$TileMap.update_bitmask_area(Vector2(column, i + y))
		
func _populate_column(column: int, x):
	for i in range(height):
		_set_tile(column, i + x, _get_tile_type(column, i + x))
		$TileMap.update_bitmask_area(Vector2(column, i + x))
		
		if _get_tile_type(column, i + x) == TILE.GRASS:
			var s = randi() % 5
			if randi() % 80 == 0:
				$TileMap2.set_cell(column, i + x, s)

func _clear_row(row: int, y):
	for i in range(width):
		_set_tile(i + y, row, -1)
		$TileMap.update_bitmask_area(Vector2(i + y, row))
		
func _populate_row(row: int, x):
	for i in range(width):
		_set_tile(i + x, row, _get_tile_type(i + x, row))
		$TileMap.update_bitmask_area(Vector2(i + x, row))
		
		if _get_tile_type(i + x, row) == TILE.GRASS:
			var s = randi() % 5
			if randi() % 80 == 0:
				$TileMap2.set_cell(i + x, row, s)	



func _get_noise_at(x, y):
	return noise.get_noise_2d(x + offset.x, y + offset.y)
	
func _get_tile_type(x, y):
	var val = _get_noise_at(x, y)
	if val < 0: return TILE.WATER
	elif val < 0.05: return TILE.SAND
	else: return TILE.GRASS

func _set_tile(x, y, tile):
	$TileMap.set_cell(x, y, tile)
