extends CharacterBody2D

@export var speed = 80

func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite2D.play("right")
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite2D.play("left")
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite2D.play("up")
	
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite2D.play("down")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite2D.stop()
	
	move_and_slide()
