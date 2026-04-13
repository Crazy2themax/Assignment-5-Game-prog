extends Node2D

@onready var label = $CanvasLayer/VBoxContainer/HBoxContainer/Label

var game_scene = preload("res://Scenes/boulder_dash.tscn")
var lang = ""

func _on_start_game_button_pressed():
	SceneManager.change_scene(game_scene, {
		"pattern" : "res://addons/scene_manager/shader_patterns/curtains.png",
		"speed": 5,
		"color" : Color.BLACK
		})


func _on_exit_game_button_pressed():
	get_tree().quit()


func _on_en_button_pressed() -> void:
	TranslationServer.set_locale("en")
	lang = "en"
	Global.save()

func _on_fr_button_pressed() -> void:
	TranslationServer.set_locale("fr")
	lang = "fr"
	SettingsManager.set_setting("graphics", "language", lang)
	Global.lang = lang


func _ready():
	Global.load_settings()

	# Load saved language
	lang = SettingsManager.get_setting("graphics", "language")
	if lang == "" or lang == null:
		lang = "en"  # default fallback

	TranslationServer.set_locale(lang)
	Global.lang = lang

	# Load highscore
	SettingsManager.set_highscore(Global.highscore)
	label.text = str(Global.highscore)
