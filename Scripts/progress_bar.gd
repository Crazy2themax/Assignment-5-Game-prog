extends ProgressBar
@export var animationSpeed := 0.1
var target_value: float = 4.0
var tween: Tween = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = 4
	value = 4
	target_value = 4 
	Global.health_changed.connect(_on_health_changed)
	var player = get_tree().get_first_node_in_group("player")

func _on_health_changed(newHealth: int):
	if tween:
		tween.kill()

	tween = create_tween()
	tween.tween_property(self, "value", float(newHealth), animationSpeed)
