extends MarginContainer

func _on_start_button_pressed():
	await LevelTransition.fade_to()
	get_tree().change_scene_to_file("res://Prefab/world.tscn")
	await LevelTransition.fade_from()
	

func _on_quit_button_pressed():
	await LevelTransition.fade_to()
	get_tree().quit()
