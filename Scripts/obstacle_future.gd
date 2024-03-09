extends RigidBody2D

var picked = false
var bodies = null

func _on_area_2d_body_entered(body):
	bodies = $Area2D.get_overlapping_bodies()

func _on_area_2d_body_exited(body):
	bodies = $Area2D.get_overlapping_bodies()

func _integrate_forces(state):
	if picked == true:
		state.transform.origin = get_node("../Player/Marker2D").global_position
		
		if get_node("../Player").teleporting_with_future_object == true:
			picked = false
			get_node("../Player").can_pick = true
			get_node("../Player").held_obstacle_future = null
			linear_velocity.y = 0
			state.transform.origin.y = get_node("../Player/Marker2D").global_position.y + 200
			get_node("../Player").teleporting_with_future_object = false
	
	if Input.is_action_just_pressed("ui_pick") and picked == false:
		if bodies != null:
			for body in bodies:
				if body.name == "Player" and get_node("../Player").can_pick == true:
					picked = true
					get_node("../Player").can_pick = false
					get_node("../Player").held_obstacle_future = self
	
	elif Input.is_action_just_pressed("ui_drop") and picked == true:
		picked = false
		get_node("../Player").can_pick = true
		get_node("../Player").held_obstacle_future = null
		linear_velocity.y = 0
		if get_node("../Player").get_node("../Player/AnimatedSprite2D").flip_h == false:
			apply_central_impulse(Vector2(70, -150))
		if get_node("../Player").get_node("../Player/AnimatedSprite2D").flip_h == true:
			apply_central_impulse(Vector2(-70, -150))





