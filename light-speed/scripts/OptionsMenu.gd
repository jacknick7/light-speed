extends MarginContainer


onready var res = [Vector2(1280,720),Vector2(1600,900),Vector2(1920,1080),Vector2(2560,1440),Vector2(3840,2160)]
onready var vol = [0, 25, 50, 75, 100]

signal back()
signal change_resolution(new_res)
signal change_volume(new_vol)
signal skip_intro(new_skip)


func _on_BackButton_pressed():
	emit_signal("back")


func _on_ResolutionOB_item_selected(index):
	emit_signal("change_resolution", res[index])


func _on_FullscreenCB_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_VsyncCB_toggled(button_pressed):
	OS.vsync_enabled = button_pressed


func _on_VolumeOB_item_selected(index):
	emit_signal("change_volume", vol[index])


func _on_SkipCB_toggled(button_pressed):
	emit_signal("skip_intro", button_pressed)
