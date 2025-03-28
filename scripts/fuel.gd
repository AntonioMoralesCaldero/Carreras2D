extends Area2D

func _ready():
	add_to_group("gasoline_pickups")

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.refill_gasoline()
		queue_free()
