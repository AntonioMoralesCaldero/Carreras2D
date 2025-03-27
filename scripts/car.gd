extends CharacterBody2D

const SPEED = 400

func _physics_process(delta):
	var direction = 0
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	velocity = Vector2(direction * SPEED, 0)
	move_and_slide()

func _on_area_2d_area_entered(area):  
	if area.is_in_group("obstacles"):  
		print("¡Game Over!")  
		get_node("/root/Main").show_game_over()  # The call for Game Over
