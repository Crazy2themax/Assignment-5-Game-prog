extends RigidBody2D

@onready var sprite = $Sprite2D

@onready var particles : CPUParticles2D = $CPUParticles2D
func _ready():
	if randf() > 0.5:
		sprite.flip_h = true
	


func _explode():
	particles.reparent(get_tree().current_scene)
	particles.emitting = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entered a body")
	_explode()
	if body.is_in_group("player"):
		body.take_damage()
	queue_free()
