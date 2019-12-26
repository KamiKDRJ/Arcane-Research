extends Area2D

onready var m0 = "res://assets/world-gen-objects/mushroom.png"
onready var m1 = "res://assets/world-gen-objects/mushrooms.png"
onready var sprites = [m0, m1]

func _ready():
	$Sprite.texture = load(sprites[randi() % sprites.size() - 1])
