extends Control

@onready var label = $MarginContainer/HBoxContainer/Label2

func _ready() -> void:
	Global.depth_changed.connect(_on_depth_changed)

	# If you want the label to show the value immediately on scene load:
	_on_depth_changed(Global.depth)

func _on_depth_changed(value: int) -> void:
	label.text = str(value) + " m"
