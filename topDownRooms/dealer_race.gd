extends CharacterBody2D

var player_in_area := false
var played_jump := false

func _physics_process(delta):
	
	# chance z index if player are infront or behind player
	var player = get_tree().current_scene.get_node("Player")
	
	if player:
		if global_position.y > player.global_position.y:
			z_index = 3
		else:
			z_index = 1
