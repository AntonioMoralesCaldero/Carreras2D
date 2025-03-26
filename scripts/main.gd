extends Node2D

@onready var obstacle_scene = preload("res://scenes/Obstacle.tscn")
@onready var parallax = $ParallaxBackground


var bg_speed = 175

func _physics_process(delta):
	parallax.scroll_offset.y += bg_speed * delta

func _on_timer_timeout():
	var obstacle = obstacle_scene.instantiate()
	obstacle.position.x = randf_range(50, get_viewport_rect().size.x - 50)
	obstacle.position.y = -100
	add_child(obstacle)
