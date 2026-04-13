extends Node

var depth := 0
var highscore := 0
var health := 4

var lang := ""

signal depth_changed(new_depth)
signal highscore_changed(new_highscore)
signal health_changed(new_health)

func _ready():
	SettingsManager.load_settings()
	SettingsManager.load_game()

	lang = SettingsManager.get_setting("graphics", "language")
	highscore = SettingsManager.get_highscore()

func update_depth(new_depth: int):
	if new_depth > depth:
		depth = new_depth
		emit_signal("depth_changed", depth)

		if depth > highscore:
			highscore = depth
			emit_signal("highscore_changed", highscore)

func update_health(new_health: int):
	health = new_health
	emit_signal("health_changed", health)

func reset_run():
	health = 4
	depth = 0
	emit_signal("depth_changed", depth)

func load_settings():
	SettingsManager.load_settings()
	lang = SettingsManager.get_setting("graphics", "language")

func save():
	SettingsManager.set_setting("graphics", "language", lang)
	SettingsManager.save_settings()
