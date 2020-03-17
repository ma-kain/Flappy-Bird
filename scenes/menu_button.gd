extends TextureButton

func _ready():
	var error = scene_changer.connect("scene_changed", self, "_on_scene_changed")
	print("connect error: ", error)

func _on_scene_changed(to_scene):
	print("_on_scene_changed: ", to_scene)
	get_tree().paused = false
	pass

func _on_menu_button_pressed():
	print("_on_menu_button_pressed")
	scene_changer.change_to_menu_stage()
