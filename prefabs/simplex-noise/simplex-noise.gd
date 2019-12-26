extends Node2D

enum TILE { GRASS, SAND, WATER }
export (NodePath) var offset_node # Used to offset the world generation
export (NodePath) var ysort

onready var Noise = OpenSimplexNoise.new()
onready var Map = $TileMap

onready var Tree = preload("res://prefabs/simplex-noise/details/tree.tscn")
onready var Rock = preload("res://prefabs/simplex-noise/details/rock.tscn")
onready var Mushroom = preload("res://prefabs/simplex-noise/details/mushrooms.tscn")

onready var details = [Tree, Rock, Mushroom]

var chunks = {} # "x,y": { 'tiles': Array2D, 'details': Array2D }
var saved_chunks = []
var chunk_size = 16
var render_width = 3
var render_height = 3

var offset = Vector2.ZERO


func _ready():
	_ini()
	
func _physics_process(_d):
	_chunk_controller()

func _chunk_controller():
	var p = get_node(offset_node)
	var s = p.global_position.snapped(Vector2(16, 16)) / 16
	var snapped = Vector2(floor(s.x / 16), floor(s.y / 16))
	
	if offset != snapped:
		if offset.x != snapped.x:
			var dir = sign(snapped.x - offset.x)
			
			for i in range(render_height):
				var x = snapped.x + (1 * dir)
				var y = offset.y + (i - render_height / 2)
				var c_name = str(x) + ',' + str(y)
				
				if saved_chunks.has(c_name): _load_chunk(x, y)
				else: _create_new_chunk(x, y)
				
				_clear_chunk(snapped.x - (render_width * dir) + (1 * dir), offset.y + (i - render_height / 2))

			offset.x = snapped.x
		
		elif offset.y != snapped.y:
			var dir = sign(snapped.y - offset.y)
			print(snapped.x)
			print(snapped.y)
			for i in range(render_width):
				var x = offset.x + (i - render_width / 2)
				var y = snapped.y + (1 * dir)
				var c_name = str(x) + ',' + str(y)
				
				if saved_chunks.has(c_name): _load_chunk(x, y)
				else: _create_new_chunk(x, y)
				
				_clear_chunk(offset.x + (i - render_width / 2), snapped.y - (render_height * dir) + (1 * dir))
				
			offset.y = snapped.y

func _ini():
	randomize()
	Noise.seed = randi()
	Noise.octaves = 4
	Noise.period = 100
	Noise.persistence = .8
	
	$TileMap.clear()
	$TileMap2.clear()
	
	for i in range(render_width):
		for j in range(render_height):
			_create_new_chunk(i - (render_width / 2), j - (render_height / 2))


func _create_new_chunk(x, y):
	var nx = x * chunk_size
	var ny = y * chunk_size
	
	for i in range(chunk_size):
		for j in range(chunk_size):
			var type = _get_tile_type(nx + i, ny + j)
			_set_tile(nx + i, ny + j,  type)
			Map.update_bitmask_area(Vector2(nx + i, ny + j))
			
			if type == TILE.GRASS:
				if randi() % 40 == 0:
					var r = randi() % details.size() - 1
					var n = details[r].instance()
					n.position = Vector2((nx + i) * 16, (ny + j) * 16)
					n.add_to_group('object')
					get_node(ysort).add_child(n)
				

func _load_chunk(x, y):
	var c_name = str(x) + ',' + str(y)
	var nx = x * chunk_size
	var ny = y * chunk_size
	if saved_chunks.has(c_name):
		var chunk = chunks[c_name]
		for i in range(chunk_size):
			for j in range(chunk_size):
				var type = chunk.tiles[i][j]
				var detail = chunk.details[i][j]
				_set_tile(nx + i, ny + j, type)
				Map.update_bitmask_area(Vector2(nx + i, ny + j))
				
				if detail >= 0:
					$TileMap2.set_cell(nx + i, ny + j,  detail)

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


func _get_noise_at(x, y):
	return Noise.get_noise_2d(x, y)
	
func _get_tile_type(x, y):
	var val = _get_noise_at(x, y)
	if val < 0: return TILE.WATER
	elif val < 0.05: return TILE.SAND
	else: return TILE.GRASS

func _set_tile(x, y, tile):
	$TileMap.set_cell(x, y, tile)
