extends Node2D

@onready var pause_menu = $Player/Camera2D/PauseMenu
@onready var collision_polygon_2d = $Past/CollisionPolygon2D
@onready var polygon_2d = $Past/CollisionPolygon2D/Polygon2D
var paused = false

func _ready():
	pause_menu.hide()
	polygon_2d.polygon = collision_polygon_2d.polygon

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		pause(paused)

func pause(state):
	if state:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_menu.hide()
		get_tree().paused = false

	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_menu.show()

