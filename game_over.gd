extends Node2D

var game_scene = preload("res://Scenes/boulder_dash.tscn")
var menu_scene = preload("res://Scenes/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(menu_scene)
