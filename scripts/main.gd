extends Node2D

@onready var obstacle_scene = preload("res://scenes/Obstacle.tscn")
@onready var background = $Sprite2D

var bg_speed = 100

func _physics_process(delta):
	background.position.y += bg_speed * delta
	
	if background.position.y >= background.texture.get_height():
		background.position.y = 0

func _on_timer_timeout():
	var obstacle = obstacle_scene.instantiate()
	obstacle.position.x = randf_range(50, get_viewport_rect().size.x - 50)
	obstacle.position.y = -100
	add_child(obstacle)
