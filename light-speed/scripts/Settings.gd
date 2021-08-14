"""
Handles the settings
Loads, applies, updates and stores the settings
"""
extends Node


const CFG_PATH = "user://settings.cfg"
const RESOLUTIONS = [
	Vector2(1280, 720),
	Vector2(1600, 900),
	Vector2(1920, 1080),
	Vector2(2560, 1440),
	Vector2(3840, 2160)
]
const VOLUMES = [0, 25, 50, 75, 100]
var config


# TODO: when sound working change the volume here or where it fits better
func initialize():
	var file = File.new()
	config = ConfigFile.new()
	if !file.file_exists(CFG_PATH): create()
	else:
		var err = config.load(CFG_PATH)
		if err != OK: print("Error " + err + " loading settings file")
	apply_fullscreen()
	apply_resolution()
	apply_vsync()
	apply_volume()
	apply_skip_intro()


func create():
	var file = File.new()
	var err = file.open(CFG_PATH, File.WRITE)
	if err == OK:
		file.close()
		if err == OK:
			config.set_value("graphics", "resolution_width", 1600)
			config.set_value("graphics", "resolution_height", 900)
			config.set_value("graphics", "resolution_id", 1)
			config.set_value("graphics", "fullscreen", false)
			config.set_value("graphics", "vsync", true)
			config.set_value("audio", "volume", 50)
			config.set_value("audio", "volume_id", 2)
			config.set_value("game", "skip_intro", false)
			config.save(CFG_PATH)
		else:
			print("Error " + err + " loading settings file")
	else: print("Error " + err + " creating settings file")


func apply_resolution():
	var size_x = config.get_value("graphics", "resolution_width")
	var size_y = config.get_value("graphics", "resolution_height")
	OS.set_window_size(Vector2(size_x, size_y))


func apply_fullscreen():
	OS.window_fullscreen = config.get_value("graphics", "fullscreen")


func apply_vsync():
	OS.vsync_enabled = config.get_value("graphics", "vsync")


# TODO: complete this once volume is implemented
func apply_volume():
	print(config.get_value("audio", "volume"))


func apply_skip_intro():
	get_parent().set_skip_intro(config.get_value("game", "skip_intro"))


func set_resolution():
	var size_x = config.get_value("graphics", "resolution_width")
	var size_y = config.get_value("graphics", "resolution_height")
	OS.set_window_size(Vector2(size_x, size_y))


func set_fullscreen():
	OS.window_fullscreen = config.get_value("graphics", "fullscreen")


func set_vsync():
	OS.vsync_enabled = config.get_value("graphics", "vsync")


# TODO: complete this once volume is implemented
func set_volume():
	print(config.get_value("audio", "volume"))


func set_skip_intro():
	get_parent().set_skip_intro(config.get_value("game", "skip_intro"))
