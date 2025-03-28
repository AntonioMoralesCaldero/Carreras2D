extends Node2D

@onready var obstacle_scene = preload("res://scenes/Obstacle.tscn")
@onready var gasoline_pickup_scene = preload("res://scenes/fuel.tscn")
@onready var parallax = $ParallaxBackground
@onready var game_over_screen = $GameOverScreen
@onready var game_over_label = $GameOverScreen/GameOverLabel
@onready var retry_button = $GameOverScreen/RetryButton
@onready var survival_time_label = $GameOverScreen/SurvivalTimeLabel

# Spawn control variables
@export var spawn_interval : float = 0.3 #Time between every obstacle spawned
@export var double_spawn_chance : float = 0.5 #Probability of 2 obstacles spawned at the same time
@export var gasoline_spawn_interval : float = 20.0 #Time every a fuel is spawned

var gasoline_spawn_timer : float = 0.0
var survival_time : float = 0.0
var game_started : bool = false

func _ready():
	game_over_screen.visible = false
	retry_button.visible = false
	survival_time_label.visible = false
	_update_ui_positions()
	retry_button.pressed.connect(_on_retry_button_pressed)
	
	$Timer.wait_time = spawn_interval
	$Timer.start()
	game_started = true

func _update_ui_positions():
	var screen_size = get_viewport_rect().size
	game_over_screen.size = screen_size
	
	game_over_label.position = Vector2(
		screen_size.x/2 - game_over_label.size.x/2,
		screen_size.y/2 - game_over_label.size.y/2 - 80
	)
	
	retry_button.position = Vector2(
		screen_size.x/2 - retry_button.size.x/2,
		screen_size.y/2 + 50
	)
	
	survival_time_label.size = Vector2(screen_size.x * 0.8, 60)
	survival_time_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	survival_time_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	survival_time_label.position = Vector2(
		screen_size.x/2 - survival_time_label.size.x/2,
		game_over_label.position.y + game_over_label.size.y + 20
	)

func _physics_process(delta):
	if !get_tree().paused and game_started:
		parallax.scroll_offset.y += 175 * delta
		survival_time += delta 
		
		gasoline_spawn_timer += delta
		if gasoline_spawn_timer >= gasoline_spawn_interval:
			gasoline_spawn_timer = 0
			_spawn_gasoline_pickup()

func _on_timer_timeout():
	_spawn_obstacle()	
	if randf() < double_spawn_chance:
		_spawn_obstacle()
	$Timer.start()

func _spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()
	obstacle.position.x = randf_range(50, get_viewport_rect().size.x - 50)
	obstacle.position.y = -100
	add_child(obstacle)
	obstacle.add_to_group("obstacles")

func _spawn_gasoline_pickup():
	var pickup = gasoline_pickup_scene.instantiate()
	pickup.position.x = randf_range(50, get_viewport_rect().size.x - 50)
	pickup.position.y = 500
	add_child(pickup)
	pickup.add_to_group("gasoline_pickups")

func show_game_over():
	game_over_screen.visible = true
	retry_button.visible = true
	survival_time_label.visible = true
	
	var minutes = int(survival_time) / 60
	var seconds = int(survival_time) % 60
	survival_time_label.text = "Has aguantado %02d:%02d" % [minutes, seconds]
	
	get_tree().paused = true
	retry_button.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_retry_button_pressed():
	print("RETRY BUTTON PRESSED - RESETTING GAME")
	game_over_screen.visible = false
	retry_button.visible = false
	survival_time_label.visible = false
	get_tree().paused = false
	survival_time = 0.0
	_clear_obstacles()
	parallax.scroll_offset = Vector2.ZERO
	get_tree().reload_current_scene()

func _clear_obstacles():
	for child in get_children():
		if child.is_in_group("obstacles") or child.is_in_group("gasoline_pickups"):
			child.queue_free()
