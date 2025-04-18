extends CharacterBody2D

var speed = 40
var direction = Vector2.ZERO

var change_direction_timer = 1.5
var time = 0.0

func _ready():
	direction = new_direction()
	$BotPanel.z_index = 3
	$BotPanel/BotSpeechBubble.z_index = 3

func _physics_process(delta):
	time += delta
	
	if time >= change_direction_timer:
		direction = new_direction()
		time = 0.0
	
	velocity = direction.normalized() * speed
	move_and_slide()
	
	if is_on_wall():
		direction = Vector2.ZERO
		$AnimatedSprite2D.stop()
		direction = new_direction()
	
	if direction == Vector2.UP:
		$AnimatedSprite2D.play("up")
	elif direction == Vector2.DOWN:
		$AnimatedSprite2D.play("down")
	elif direction == Vector2.LEFT:
		$AnimatedSprite2D.play("left")
	elif direction == Vector2.RIGHT:
		$AnimatedSprite2D.play("right")
	elif direction == Vector2.ZERO:
		$AnimatedSprite2D.stop()
	
	# chance z index if bots are infront or behind player
	var player = get_tree().current_scene.get_node("Player")
	if player:
		if global_position.y > player.global_position.y:
			z_index = 3
		else:
			z_index = 1

func new_direction():
	var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT, Vector2.ZERO]
	return directions.pick_random()
