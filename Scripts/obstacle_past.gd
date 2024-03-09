extends RigidBody2D

var picked = false
var bodies = null

func _on_area_2d_body_entered(body):
	bodies = $Area2D.get_overlapping_bodies()

func _on_area_2d_body_exited(body):
	bodies = $Area2D.get_overlapping_bodies()

func _integrate_forces(state):
	
	if get_node("../Player").can_pick == false:
		set_collision_mask_value(3, false)
	else:
		set_collision_mask_value(3, true)
	
	if picked == true:
		state.transform.origin = get_node("../Player/Marker2D").global_position

		if get_node("../Player").teleporting_with_past_object == true:
			picked = false
			get_node("../Player").can_pick = true
			get_node("../Player").held_obstacle_past = null
			linear_velocity.y = 0
			state.transform.origin.y = get_node("../Player/Marker2D").global_position.y - 255
			get_node("../Player").teleporting_with_past_object = false
			calculate_future(true)
			


	if Input.is_action_just_pressed("ui_pick") and picked == false:
		if bodies != null:
			for body in bodies:
				if body.name == "Player" and get_node("../Player").can_pick == true:
					picked = true
					#print(get_node("../Box Future"))
					
					#if get_node(".").get_index() < get_node("../Box Future").get_index():
						#get_node("../").move_child(get_node("."),get_node("../Box Future").get_index())
					get_node("../Player").can_pick = false
					get_node("../Player").held_obstacle_past = self
					calculate_future()
					


	elif Input.is_action_just_pressed("ui_drop") and picked == true:
		picked = false
		get_node("../Player").can_pick = true
		get_node("../Player").held_obstacle_past = null
		linear_velocity.y = 0
		if get_node("../Player").get_node("../Player/AnimatedSprite2D").flip_h == false:
			apply_central_impulse(Vector2(70, -150))
		if get_node("../Player").get_node("../Player/AnimatedSprite2D").flip_h == true:
			apply_central_impulse(Vector2(-70, -150))
			
		calculate_future()
		
		if get_node("../Player").get_node("../Player/AnimatedSprite2D").flip_h == false:
			get_child(3).apply_central_impulse(Vector2(70, -150))
		if get_node("../Player").get_node("../Player/AnimatedSprite2D").flip_h == true:
			get_child(3).apply_central_impulse(Vector2(-70, -150))
			
func calculate_future(player = false):
	var vector = 0
	if player == true: vector = Vector2(get_node("../Player/Marker2D").global_position.x, get_node("../Player/Marker2D").global_position.y)
	else : vector = Vector2($".".global_position.x, get_node("../Player/Marker2D").global_position.y + 255)
	PhysicsServer2D.body_set_state(
	get_child(3).get_rid(),
	PhysicsServer2D.BODY_STATE_TRANSFORM,
	Transform2D.IDENTITY.translated(vector)
	)
	
