extends RigidBody2D

var picked = false

func _physics_process(delta):
	if picked == true:
		self.position = get_node("../Player/Marker2D").global_position
		
func _input(event):
	if Input.is_action_just_pressed("ui_pick") and picked == false:
		self.angular_velocity = 0
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").can_pick == true:
				picked = true
				get_node("../Player").can_pick = false
				
	elif Input.is_action_just_pressed("ui_drop") and picked == true:
		self.freeze = true
		await get_tree().create_timer(0.1).timeout 
		self.freeze = false
		self.linear_velocity.y = 0
		self.linear_velocity.x = get_node("../Player").velocity.x * 1.5
		picked = false
		get_node("../Player").can_pick = true
		
	elif Input.is_action_just_pressed("ui_throw") and picked == true:
		picked = false
		get_node("../Player").can_pick = true
		if get_node("../Player").get_node("../Player/AnimatedSprite2D").flip_h == false:
			self.linear_velocity.x = 250
			self.linear_velocity.y = -250
			self.angular_velocity = 10
			self.inertia = 100
			apply_impulse(Vector2(), Vector2(150, -200))
		else:
			self.linear_velocity.x = -250
			self.linear_velocity.y = -250
			self.angular_velocity = 10
			self.inertia = 100
			apply_impulse(Vector2(), Vector2(-150, -200))
