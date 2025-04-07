extends CharacterBody2D

var is_jumping = false

const SPEED = 500.0
const JUMP_VELOCITY = -500.0

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else: 
		is_jumping = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	update_animation(direction)
	move_and_slide()

func update_animation(direction):
	if direction != 0:
		animated_sprite_2d.flip_h = (direction < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
