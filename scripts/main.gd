extends Node2D

@onready var obstacle_scene = preload("res://scenes/Obstacle.tscn")
@onready var parallax = $ParallaxBackground
@onready var game_over_screen = $GameOverScreen
@onready var game_over_label = $GameOverScreen/GameOverLabel
@onready var retry_button = $GameOverScreen/RetryButton


func _ready():
	game_over_screen.visible = false  # To set it insible at the beginning
	retry_button.visible = false
	game_over_screen.set_size(get_viewport_rect().size)

func _physics_process(delta):
	if !get_tree().paused:
		parallax.scroll_offset.y += 175 * delta

func _on_timer_timeout():
	var obstacle = obstacle_scene.instantiate()
	obstacle.position.x = randf_range(50, get_viewport_rect().size.x - 50)
	obstacle.position.y = -100
	add_child(obstacle)

func show_game_over():
	game_over_screen.visible = true
	retry_button.visible = true
	get_tree().paused = true  # Pause the game at the end

func _on_retry_button_pressed() -> void:
	print("Retry button pressed!")
	get_tree().paused = false
	get_tree().reload_current_scene()  # To play again
