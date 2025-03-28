extends CharacterBody2D

const SPEED = 400
@export var max_fuel : float = 100.0
@export var fuel_consumption_rate : float = 2.5 # Fuel consumed per second
var current_fuel : float = 100.0

@onready var fuel_bar := $FuelBar

func _ready():
	add_to_group("player")
	update_fuel_display()

func _physics_process(delta):
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity = Vector2(direction * SPEED, 0)
	move_and_slide()
	
	# Fuel consumption
	current_fuel -= fuel_consumption_rate * delta
	update_fuel_display()
	
	if current_fuel <= 0:
		get_node("/root/Main").show_game_over()

func _on_area_2d_area_entered(area):  
	if area.is_in_group("obstacles"):  
		print("¡Game Over!")  
		get_node("/root/Main").show_game_over()
	elif area.is_in_group("gasoline_pickups"):
		refill_gasoline()

func refill_gasoline():
	current_fuel = max_fuel
	update_fuel_display()

func update_fuel_display():
	fuel_bar.value = current_fuel
