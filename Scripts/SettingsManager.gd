extends Node

const SETTINGS_FILE := "user://ui_settings.cfg"
const SAVE_FILE := "user://ui_savegame.json"

var settings : Dictionary = {
	"graphics": {
		"language": "en"
	}
}

var save_data := {
	"highscore": 0
}

var config := ConfigFile.new()

func _ready():
	load_settings()
	load_game()

# -------------------------
# SETTINGS (LANGUAGE ONLY)
# -------------------------

func get_setting(category: String, key: String):
	return settings.get(category, {}).get(key, null)

func set_setting(category: String, key: String, value):
	if settings.has(category):
		settings[category][key] = value
		save_settings()

func save_settings():
	for category in settings.keys():
		for key in settings[category].keys():
			config.set_value(category, key, settings[category][key])
	config.save(SETTINGS_FILE)

func load_settings():
	if config.load(SETTINGS_FILE) == OK:
		for category in settings.keys():
			for key in settings[category].keys():
				settings[category][key] = config.get_value(category, key, settings[category][key])

# -------------------------
# SAVEGAME (HIGHSCORE ONLY)
# -------------------------

func save_game():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data, "\t"))
		file.close()

func load_game():
	if FileAccess.file_exists(SAVE_FILE):
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
		if file:
			var parsed = JSON.parse_string(file.get_as_text())
			if parsed is Dictionary:
				save_data = parsed
			file.close()

func set_highscore(value: int):
	save_data["highscore"] = value
	save_game()

func get_highscore() -> int:
	return save_data.get("highscore", 0)
