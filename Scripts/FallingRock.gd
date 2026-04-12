extends RigidBody2D

@onready var sprite = $Sprite2D

func _ready():
	if randf() > 0.5:
		sprite.flip_h = true


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.take_dammage()
		queue_free()
