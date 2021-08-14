extends MarginContainer


var settings
signal back()


func initialize(new_settings):
	settings = new_settings
	$HBoxContainer/VBoxContainer/DisplayOptions/HBoxContainer2/ResolutionOB.selected = settings.get_resolution_id()
	$HBoxContainer/VBoxContainer/DisplayOptions/HBoxContainer3/FullscreenCB.pressed = settings.get_fullscreen()
	$HBoxContainer/VBoxContainer/DisplayOptions/HBoxContainer6/VsyncCB.pressed = settings.get_vsync()
	$HBoxContainer/VBoxContainer/DisplayOptions/HBoxContainer4/VolumeOB.selected = settings.get_volume_id()
	$HBoxContainer/VBoxContainer/DisplayOptions/HBoxContainer5/SkipCB.pressed = settings.get_skip_intro()


func _on_BackButton_pressed():
	emit_signal("back")


func _on_ResolutionOB_item_selected(index):
	settings.set_resolution(index)


func _on_FullscreenCB_toggled(button_pressed):
	settings.set_fullscreen(button_pressed)


func _on_VsyncCB_toggled(button_pressed):
	settings.set_vsync(button_pressed)


func _on_VolumeOB_item_selected(index):
	settings.set_volume(index)


func _on_SkipCB_toggled(button_pressed):
	settings.set_skip_intro(button_pressed)

