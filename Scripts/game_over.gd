extends Node2D

@onready var current_depth = $CanvasLayer/VBoxContainer/VBoxContainer/HBoxContainer/CurrentScoreDepthLabel
@onready var highscore_depth = $CanvasLayer/VBoxContainer/VBoxContainer/HBoxContainer2/HighScoreDepthLabel

var game_scene = preload("res://Scenes/boulder_dash.tscn")
var menu_scene = preload("res://Scenes/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.depth_changed.connect(_on_depth_changed)
	Global.highscore_changed.connect(_on_highscore_changed)

	# If you want the label to show the value immediately on scene load:
	_on_depth_changed(Global.depth)
	_on_highscore_changed(Global.highscore)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_again_button_pressed() -> void:
	Global.reset_run()
	get_tree().change_scene_to_packed(game_scene)

func _on_main_menu_button_pressed() -> void:
	Global.reset_run()
	get_tree().change_scene_to_packed(menu_scene)

func _on_depth_changed(value: int) -> void:
	current_depth.text = str(value) + " m"

func _on_highscore_changed(value: int) -> void:
	highscore_depth.text = str(value) + " m"
