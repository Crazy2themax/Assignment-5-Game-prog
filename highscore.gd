extends Control

@onready var current_depth = $CanvasLayer/VBoxContainer/VBoxContainer/HBoxContainer/CurrentScoreDepthLabel
@onready var highscore_depth = $CanvasLayer/VBoxContainer/VBoxContainer/HBoxContainer2/HighScoreDepthLabel

func _ready() -> void:
	Global.depth_changed.connect(_on_depth_changed)
	Global.highscore_changed.connect(_on_highscore_changed)

	# If you want the label to show the value immediately on scene load:
	_on_depth_changed(Global.depth)
	_on_highscore_changed(Global.highscore)

func _on_depth_changed(value: int) -> void:
	current_depth.text = str(value) + " m"

func _on_highscore_changed(value: int) -> void:
	highscore_depth.text = str(value) + " m"
