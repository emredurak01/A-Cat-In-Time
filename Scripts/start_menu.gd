extends MarginContainer

var increase = 0
var started = false

func _physics_process(delta):
	if started: 
		increase += delta
		$Sprite2D.material.set_shader_parameter("progress", increase)

func _on_start_button_pressed():
	started = true
	await LevelTransition.fade_to()
	
	get_tree().change_scene_to_file("res://Prefab/world.tscn")
	started = false

func _on_quit_button_pressed():
	get_tree().quit()
