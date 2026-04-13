extends Control

func _ready() -> void:
	Global.depth_changed.connect(_on_depth_changed)

	# If you want the label to show the value immediately on scene load:
	_on_depth_changed(Global.depth)

func _on_depth_changed(value: int) -> void:
	$MarginContainer/HBoxContainer/Label2.text = str(value)
