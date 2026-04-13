extends Area2D

func _on_body_entered(body: Node2D) -> void:
	visible = false
	Global.health = 4
	Global.update_health(Global.health)
	queue_free()
