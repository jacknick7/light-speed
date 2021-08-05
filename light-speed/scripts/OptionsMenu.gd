extends MarginContainer


onready var res = [Vector2(1280,720),Vector2(1600,900),Vector2(1920,1080),Vector2(2560,1440),Vector2(3840,2160)]
onready var vol = [0, 25, 50, 75, 100]

signal back()
signal change_resolution(new_res)
signal change_volume(new_vol)
signal skip_intro(new_skip)


func initialize():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		#$HBoxContainer/VBoxContainer/DisplayOptions/HBoxContainer2/ResolutionOB.select()
		$HBoxContainer/VBoxContainer/DisplayOptions/HBoxContainer3/FullscreenCB.pressed = config.get_value("graphics", "fullscreen")
		$HBoxContainer/VBoxContainer/DisplayOptions/HBoxContainer6/VsyncCB.pressed = config.get_value("graphics", "vsync")
		#$HBoxContainer/VBoxContainer/DisplayOptions/HBoxContainer4/VolumeOB.pressed = config.get_value("graphics", "fullscreen")
		$HBoxContainer/VBoxContainer/DisplayOptions/HBoxContainer5/SkipCB.pressed = config.get_value("game", "skip_intro")
	else:
		print("Error " + err + " loading ConfigFile")


func _on_BackButton_pressed():
	emit_signal("back")


func _on_ResolutionOB_item_selected(index):
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		config.set_value("graphics", "display_height", res[index].y)
		config.save("user://settings.cfg")
	else:
		print("Error " + err + " loading ConfigFile")
	emit_signal("change_resolution", res[index])


func _on_FullscreenCB_toggled(button_pressed):
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		config.set_value("graphics", "fullscreen", button_pressed)
		config.save("user://settings.cfg")
	else:
		print("Error " + err + " loading ConfigFile")
	OS.window_fullscreen = button_pressed


func _on_VsyncCB_toggled(button_pressed):
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		config.set_value("graphics", "vsync", button_pressed)
		config.save("user://settings.cfg")
	else:
		print("Error " + err + " loading ConfigFile")
	OS.vsync_enabled = button_pressed


func _on_VolumeOB_item_selected(index):
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		config.set_value("audio", "volume", vol[index])
		config.save("user://settings.cfg")
	else:
		print("Error " + err + " loading ConfigFile")
	emit_signal("change_volume", vol[index])


func _on_SkipCB_toggled(button_pressed):
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		config.set_value("game", "skip_intro", button_pressed)
		config.save("user://settings.cfg")
	else:
		print("Error " + err + " loading ConfigFile")
	emit_signal("skip_intro", button_pressed)
