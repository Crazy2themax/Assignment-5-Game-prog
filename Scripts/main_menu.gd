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
	SettingsManager.set_setting("graphics", "language", "en")
	Global.lang = "en"
	TranslationServer.set_locale("en")

func _on_fr_button_pressed() -> void:
	SettingsManager.set_setting("graphics", "language", "fr")
	Global.lang = "fr"
	TranslationServer.set_locale("fr")

func _ready():
	Global.load_settings()

	# Load saved language
	lang = SettingsManager.get_setting("graphics", "language")
	if lang == "" or lang == null:
		lang = "en"

	TranslationServer.set_locale(lang)
	Global.lang = lang

	# Load highscore (do NOT save here)
	Global.highscore = SettingsManager.get_highscore()
	label.text = str(Global.highscore)
