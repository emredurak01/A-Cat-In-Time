extends CharacterBody2D

const SPEED = 100.0
const ACCELERATION =  800.0
const FRICTION = 1000.0
const JUMP_VELOCITY = -300.0
const CROUCH_SPEED = 50.0
const CROUCH_ACCELERATION = 400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $CollisionShape2D
@onready var sprite_animate = $AnimatedSprite2D #for animation

var allow_jump = true
var crouch_state = true
var push_force = 50.0

func _ready():
	sprite_animate.play("idle") #idle animation on boot

func _physics_process(delta):
	# Add the gravity.
	#Also modifies so the cat doesnt jump infinitely (singular)
	if not is_on_floor():
		velocity.y += gravity * delta
		allow_jump = false
	else:
		allow_jump = true
		
	#crouch handling
	if Input.is_action_pressed("ui_down"):
		crouch_state = true
		velocity.x = move_toward(velocity.x, 0, CROUCH_ACCELERATION * delta)
	else:
		crouch_state = false
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if crouch_state:
			velocity.x = move_toward(velocity.x, CROUCH_SPEED*direction, CROUCH_ACCELERATION*delta)
			sprite_animate.play("crouch")
			sprite_animate.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, SPEED*direction, ACCELERATION*delta)
			sprite_animate.play("run")
			sprite_animate.flip_h = direction < 0 #direction turn when moving in opposed direction
	else:
		if crouch_state:
			velocity.x = move_toward(velocity.x, 0, CROUCH_ACCELERATION*delta)
			sprite_animate.play("crouch")
		else:
			velocity.x = move_toward(velocity.x, 0, FRICTION*delta)
			sprite_animate.play("idle")
			
	for index in get_slide_collision_count():
			var body = get_slide_collision(index)
			if body.get_collider() is RigidBody2D:
				body.get_collider().apply_central_impulse(-body.get_normal()*push_force)

	move_and_slide()
