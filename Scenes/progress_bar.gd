extends ProgressBar
@export var animationSpeed := 5.0
var target_value: float = 4.0


 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = 4
	value = 4
	target_value =4 
	var player = get_tree().get_first_node_in_group("player")
	

func _on_health_changed(newHealth: int):
	target_value = float(newHealth)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = lerp(value, target_value, delta* animationSpeed)
