extends MarginContainer

@onready var world = $"../../../"

func _on_continue_button_pressed():
	world.pause(true)

func _on_quit_button_pressed():
	get_tree().quit()
