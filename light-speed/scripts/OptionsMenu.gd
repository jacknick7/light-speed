extends MarginContainer


onready var res = [720, 900, 1080, 1440, 2160]
onready var vol = [0, 25, 50, 75, 100]

signal back()


func _on_BackButton_pressed():
	emit_signal("back")


func _on_ResolutionOB_item_selected(index):
	print("Res: " + str(res[index]))


func _on_FullscreenCB_toggled(button_pressed):
	print(OS.window_fullscreen)
	OS.window_fullscreen = button_pressed
	print("Full: " + str(button_pressed))


func _on_VsyncCB_toggled(button_pressed):
	print(OS.vsync_enabled)
	OS.vsync_enabled = button_pressed
	print("Vsync: " + str(button_pressed))


func _on_VolumeOB_item_selected(index):
	print("Res: " + str(vol[index]))


func _on_SkipCB_toggled(button_pressed):
	print("Skip: " + str(button_pressed))
