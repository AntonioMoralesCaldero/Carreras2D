extends CharacterBody2D

const SPEED = 300  # Velocidad del coche

func _physics_process(delta):
	var direction = 0
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	velocity = Vector2(direction * SPEED, 0)  # Movimiento solo en X
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("obstacles"):
		print("¡Game Over!")
		get_tree().reload_current_scene()
