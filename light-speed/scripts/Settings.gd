"""
Handles the settings
Loads, applies, updates and stores the settings
"""
extends Node


const CFG_PATH = "user://settings.cfg"
const RESOLUTIONS = [
	Vector2(1280, 720), Vector2(1600, 900), Vector2(1920, 1080),
	Vector2(2560, 1440), Vector2(3840, 2160)
]
const VOLUMES = [0, 25, 50, 75, 100]
var config


# TODO: when sound working change the volume here or where it fits better
func initialize():
	"""
	Loads or creates the settings and applies them.
	"""
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
	"""
	Creates a new file to store the settings, sets initial values and stores them.
	"""
	var file = File.new()
	var err = file.open(CFG_PATH, File.WRITE)
	if err == OK:
		file.close()
		config.set_value("graphics", "resolution_width", 1600)
		config.set_value("graphics", "resolution_height", 900)
		config.set_value("graphics", "resolution_id", 1)
		config.set_value("graphics", "fullscreen", false)
		config.set_value("graphics", "vsync", true)
		config.set_value("audio", "volume", 50)
		config.set_value("audio", "volume_id", 2)
		config.set_value("game", "skip_intro", false)
		err = config.save(CFG_PATH)
		if err != OK: print("Error " + err + " saving settings file")
	else: print("Error " + err + " creating settings file")


func apply_resolution():
	"""
	Applies current resolution value.
	"""
	var size_x = config.get_value("graphics", "resolution_width")
	var size_y = config.get_value("graphics", "resolution_height")
	OS.set_window_size(Vector2(size_x, size_y))


func apply_fullscreen():
	"""
	Applies current fullscreen value.
	"""
	OS.window_fullscreen = config.get_value("graphics", "fullscreen")


func apply_vsync():
	"""
	Applies current vsync value.
	"""
	OS.vsync_enabled = config.get_value("graphics", "vsync")


# TODO: complete this once volume is implemented
func apply_volume():
	"""
	Applies current volume value.
	"""
	#print(config.get_value("audio", "volume"))
	pass


func apply_skip_intro():
	"""
	Applies current skip_intro value.
	"""
	get_parent().set_skip_intro(config.get_value("game", "skip_intro"))


# TODO: change HexagonMatrix resolution
func set_resolution(res_id):
	"""
	Sets new resolution values, stores it and then applies.
	"""
	config.set_value("graphics", "resolution_width", int(RESOLUTIONS[res_id].x))
	config.set_value("graphics", "resolution_height", int(RESOLUTIONS[res_id].y))
	config.set_value("graphics", "resolution_id", res_id)
	var err = config.save(CFG_PATH)
	if err != OK: print("Error " + err + " saving settings file")
	apply_resolution()


func set_fullscreen(is_fullscreen):
	"""
	Sets new fullscreen value, stores it and then applies.
	"""
	config.set_value("graphics", "fullscreen", is_fullscreen)
	var err = config.save(CFG_PATH)
	if err != OK: print("Error " + err + " saving settings file")
	apply_fullscreen()


func set_vsync(is_vsync):
	"""
	Sets new vsync value, stores it and then applies.
	"""
	config.set_value("graphics", "vsync", is_vsync)
	var err = config.save(CFG_PATH)
	if err != OK: print("Error " + err + " saving settings file")
	apply_vsync()


func set_volume(vol_id):
	"""
	Sets new volume values, stores it and then applies.
	"""
	config.set_value("audio", "volume", VOLUMES[vol_id])
	config.set_value("audio", "volume_id", vol_id)
	var err = config.save(CFG_PATH)
	if err != OK: print("Error " + err + " saving settings file")
	apply_volume()


func set_skip_intro(is_skip_intro):
	"""
	Sets new skip_intro value, stores it and then applies.
	"""
	config.set_value("game", "skip_intro", is_skip_intro)
	var err = config.save(CFG_PATH)
	if err != OK: print("Error " + err + " saving settings file")
	apply_skip_intro()


func get_resolution_id():
	"""
	Gets resolution_id value.
	"""
	return config.get_value("graphics", "resolution_id")


func get_fullscreen():
	"""
	Gets fullscreen value.
	"""
	return config.get_value("graphics", "fullscreen")


func get_vsync():
	"""
	Gets vsync value.
	"""
	return config.get_value("graphics", "vsync")


func get_volume_id():
	"""
	Gets volume_id value.
	"""
	return config.get_value("audio", "volume_id")


func get_skip_intro():
	"""
	Gets skip_intro value.
	"""
	return config.get_value("game", "skip_intro")

