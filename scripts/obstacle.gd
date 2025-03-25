extends Area2D

@onready var sprite = $Sprite2D

var speed = 250
var textures = [ 
	preload("res://assets/obstaculo2.png"),
	preload("res://assets/obstaculo3.png"),
	preload("res://assets/obstaculo5.png"),
	preload("res://assets/obstaculo7.png"),
]

func _ready():
	sprite.texture = textures[randi() % textures.size()]

func _physics_process(delta):
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()
