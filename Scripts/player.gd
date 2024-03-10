extends CharacterBody2D

const SPEED = 150.0
const ACCELERATION =  800.0
const FRICTION = 1000.0
const JUMP_VELOCITY = -325.0
const CROUCH_SPEED = 50.0
const CROUCH_ACCELERATION = 400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $CollisionShape2D
@onready var sprite_animate = $AnimatedSprite2D #for animation
@onready var camera = $Camera2D
@onready var time_shader = $TimeShader

var teleporting_with_past_object = false
var teleporting_with_future_object = false
var allow_jump = true
var jump_state = true
var future_state = false
var can_pick = true
var can_leap: bool = true
var teleporting = false
var just_teleported = false
var allow_teleport = true

var held_obstacle_past : RigidBody2D = null
var held_obstacle_future : RigidBody2D = null

var push_force = 30


func _ready():
	sprite_animate.play("idle") #idle animation on boot

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		allow_jump = false
		allow_teleport = false
		if velocity.y < 0: sprite_animate.play("jumping_up")
		else: sprite_animate.play("falling_down")
	else:
		jump_state = false
		allow_jump = true
		allow_teleport = true
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		if (!teleporting):
			jump_state = true
			velocity.y = JUMP_VELOCITY

	#Time travel
	if Input.is_action_just_pressed("ui_accept") and can_leap and allow_teleport:
		sprite_animate.play("sleep")
		teleporting = true
		time_shader.material.set_shader_parameter("chaos",32)
		$TLCooldown.start()
		can_leap = false
		await get_tree().create_timer(1.6).timeout
		sprite_animate.play("wake_up")
		just_teleported = true
		
		if future_state == false:
			position.y += 255
			camera.limit_top = 255
			camera.limit_bottom = 255
			future_state = true
			if(held_obstacle_past != null):
				teleporting_with_past_object = true
			if(held_obstacle_future != null):
				teleporting_with_future_object = true
			teleporting = false
			await get_tree().create_timer(1.6).timeout
			time_shader.material.set_shader_parameter("chaos",0)
		else:
			position.y -= 255
			camera.limit_top = 0
			camera.limit_bottom = 0
			future_state = false
			if(held_obstacle_past != null):
				teleporting_with_past_object = true
			if(held_obstacle_future != null):
				teleporting_with_future_object = true
			teleporting = false
			await get_tree().create_timer(1.6).timeout
			time_shader.material.set_shader_parameter("chaos",0)
		just_teleported = false

	var direction = Input.get_axis("ui_left", "ui_right")
	if (!teleporting and !just_teleported):
		if direction:
				velocity.x = move_toward(velocity.x, SPEED*direction, ACCELERATION*delta)
				if !jump_state: sprite_animate.play("run")
				sprite_animate.flip_h = direction < 0
		else:
				velocity.x = move_toward(velocity.x, 0, FRICTION*delta)
				if !jump_state and just_teleported == false: 
					sprite_animate.play("idle")
				
		for index in get_slide_collision_count():
				var body = get_slide_collision(index)
				if body.get_collider() is RigidBody2D:
					body.get_collider().apply_central_impulse(-body.get_normal()*push_force)

		move_and_slide()
	
func _on_tl_cooldown_timeout():
	can_leap = true

