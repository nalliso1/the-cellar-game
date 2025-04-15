extends CharacterBody2D

var win_size : Vector2
const start_speed : int = 500
const accel : int = 50
var speed : int
var dir : Vector2
const max_y_vector : float = 0.6

@onready var bounce_sound = $BounceSound  

func _ready(): 
	win_size = get_viewport_rect().size
	new_ball()

func new_ball(): 
	position.x = win_size.x / 2
	position.y = clamp(randi_range(200, win_size.y - 200), 200, win_size.y - 200)
	speed = start_speed
	dir = random_direction()

func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	if collision: 
		var collider = collision.get_collider()
		
		if collider == $"../Player" or collider == $"../CPU": 
			speed += accel
			dir = new_direction(collider)
			bounce_sound.play()
		

		else: 
			dir = dir.bounce(collision.get_normal())
			bounce_sound.play()  

func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	new_dir.x = -1 if dir.x > 0 else 1
	new_dir.y = (dist / (collider.p_height / 2)) * max_y_vector
	return new_dir.normalized()
	
func random_direction(): 
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-0.5, 0.5)  
	return new_dir.normalized()
