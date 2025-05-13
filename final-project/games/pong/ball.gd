extends CharacterBody2D

const start_speed : int = 400
const accel : int = 50
var speed : int
var dir : Vector2
var paused := false

@onready var bounce_sound = $BounceSound  

func _ready(): 
	new_ball()

func new_ball(): 
	position = Vector2(512, 245)
	speed = start_speed
	dir = random_direction()
	paused = false
	visible = true

func hide_and_pause():
	visible = false
	paused = true

func _physics_process(delta):
	if paused:
		return

	var collision = move_and_collide(dir * speed * delta)
	if collision: 
		var collider = collision.get_collider()

		# Bounce off paddles
		if collider == $"../Player" or collider == $"../CPU": 
			speed += accel
			dir = new_direction(collider)
			bounce_sound.play()

		# Bounce off walls
		elif collider.is_in_group("Walls"):
			dir = dir.bounce(collision.get_normal())
			bounce_sound.play()

		else:
			
			return

func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	new_dir.x = -1 if dir.x > 0 else 1
	new_dir.y = randf_range(-0.5, 0.5)
	return new_dir.normalized()

func random_direction(): 
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-0.5, 0.5)  
	return new_dir.normalized()
