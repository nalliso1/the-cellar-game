extends CharacterBody2D

func _physics_process(delta):
	
	$AnimatedSprite2D.play("idle")
	
	# chance z index if bots are infront or behind player
	var player = get_tree().current_scene.get_node("Player")
	if player:
		if global_position.y > player.global_position.y:
			z_index = 3
		else:
			z_index = 1
