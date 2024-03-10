extends Node2D

@onready var vfx_box_time_travel_v_1 = $vfx_BoxTimeTravel_v1
@onready var player = $Player
@onready var camera = $Player/Camera2D
@onready var pause_menu = $Player/Camera2D/PauseMenu
@onready var collision_polygon_2d = $Past/CollisionPolygon2D
@onready var polygon_2d = $Past/CollisionPolygon2D/Polygon2D
var paused = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_menu.hide()
	polygon_2d.polygon = collision_polygon_2d.polygon

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		pause(paused)
		
	if (player.held_obstacle_past != null):
		var held_obstacle_past = find_child(player.held_obstacle_past.name)
		var obstacle_future = held_obstacle_past.find_child("Box Future")
		$vfx_BoxTimeTravel_v1.global_position = obstacle_future.teleport_position
		
		if (obstacle_future.teleport_position.y > 255):
			await get_tree().create_timer(0.5).timeout
		else:
			$vfx_BoxTimeTravel_v1.emitting = true
			await get_tree().create_timer(0.5).timeout
		

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

