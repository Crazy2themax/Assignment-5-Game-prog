extends Node2D

@onready var label = $CanvasLayer/VBoxContainer/HBoxContainer/Label

var game_scene = preload("res://Scenes/boulder_dash.tscn")
var lang = ""


func _on_start_game_button_pressed():
	get_tree().change_scene_to_packed(game_scene)


func _on_exit_game_button_pressed():
	get_tree().quit()


func _on_en_button_pressed() -> void:
	TranslationServer.set_locale("en")
	lang = "en"

func _on_fr_button_pressed() -> void:
	TranslationServer.set_locale("fr")
	lang = "fr"

func _ready():
	label.text = str(Global.highscore)
