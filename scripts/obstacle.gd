extends Area2D

@onready var sprite = $Sprite2D

var speed = 250
var textures = [ 
	preload("res://assets/obstaculo2.png"),
	preload("res://assets/obstaculo3.png"),
	preload("res://assets/obstaculo4.png"),
	preload("res://assets/obstaculo5.png"),
	preload("res://assets/obstaculo6.png"),
	preload("res://assets/obstaculo7.png"),
	preload("res://assets/obstaculo8.png"),
	preload("res://assets/obstaculo9.png"),
	preload("res://assets/obstaculo10.png"),
	preload("res://assets/obstaculo11.png"),
	preload("res://assets/obstaculo12.png"),
	preload("res://assets/obstaculo13.png"),
	preload("res://assets/obstaculo14.png"),
	preload("res://assets/obstaculo15.png"),
	preload("res://assets/obstaculo16.png")
]

func _ready():
	sprite.texture = textures[randi() % textures.size()]

func _physics_process(delta):
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()
