extends RigidBody2D

var picked = false

func _physics_process(delta):
	if picked == true:
		self.position = get_node("../Player/Marker2D").global_position
		

func _input(event):
	if Input.is_action_just_pressed("ui_pick") and picked == false:
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").can_pick == true:
				picked = true
				get_node("../Player").can_pick = false

	elif Input.is_action_just_pressed("ui_drop") and picked == true:
		self.set_physics_process(true)
		picked = false
		get_node("../Player").can_pick = true
		if get_node("../Player").get_node("../Player/AnimatedSprite2D").flip_h == false:
			apply_impulse(Vector2(), Vector2(20, -5))
		else:
			apply_impulse(Vector2(), Vector2(-20, -5))
			
	elif Input.is_action_just_pressed("ui_throw") and picked == true:
		picked = false
		get_node("../Player").can_pick = true
		if get_node("../Player").get_node("../Player/AnimatedSprite2D").flip_h == false:
			apply_impulse(Vector2(), Vector2(150, -200))
		else:
			apply_impulse(Vector2(), Vector2(-150, -200))
