extends Node

@onready var animation_player = $AnimationPlayer

func fade_from():
	animation_player.play("fade_from")
	await animation_player.animation_finished

func fade_to():
	animation_player.play("fade_to")
	await animation_player.animation_finished
