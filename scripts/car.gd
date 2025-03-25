extends CharacterBody2D

const SPEED = 300

func _physics_process(delta):
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	velocity = direction * SPEED
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("obstacles"):
		print("¡Game Over!")
		get_tree().reload_current_scene()
