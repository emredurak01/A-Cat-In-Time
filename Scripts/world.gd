extends Node2D

@onready var player = $Player
@onready var camera = $Player/Camera2D
@onready var pause_menu = $Player/Camera2D/PauseMenu
@onready var collision_polygon_2d = $Past/CollisionPolygon2D
@onready var polygon_2d = $Past/CollisionPolygon2D/Polygon2D
@onready var box_past = $"Box Past"
@onready var box_future = $"Box Past/Box Future"

var paused = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_menu.hide()
	polygon_2d.polygon = collision_polygon_2d.polygon
	

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		pause(paused)
		
	#if (player.held_obstacle_past != null):
		#print(player.held_obstacle_past.position)
		#box_future.global_position = player.held_obstacle_past.position + Vector2(0, 200)
		

func pause(state):
	pause_menu.position.y = (camera.limit_top - player.position.y)
	if state:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_menu.hide()
		get_tree().paused = false

	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_menu.show()

