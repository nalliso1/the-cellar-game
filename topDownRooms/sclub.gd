extends Node2D

var speech_zone = false

func _on_speech_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$dealer_race/AnimatedSprite2D.play("jump")
		$DealerRacePanel.visible = true
		$DealerRacePanel/DealerRaceSpeechBubble.visible = true
		speech_zone = true

func _on_speech_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$dealer_race/AnimatedSprite2D.play("idle")
		$DealerRacePanel.visible = false
		$DealerRacePanel/DealerRaceSpeechBubble.visible = false
		speech_zone = false

func _on_bot_5_area_body_entered(body):
	if body.is_in_group("player"):
		$Bot_5/BotPanel.visible = true
		$Bot_5/BotPanel/BotSpeechBubble.visible = true

func _on_bot_5_area_body_exited(body):
	if body.is_in_group("player"):
		$Bot_5/BotPanel.visible = false
		$Bot_5/BotPanel/BotSpeechBubble.visible = false

func _on_bot_6_area_body_entered(body):
	if body.is_in_group("player"):
		$Bot_6/BotPanel.visible = true
		$Bot_6/BotPanel/BotSpeechBubble.visible = true

func _on_bot_6_area_body_exited(body):
	if body.is_in_group("player"):
		$Bot_6/BotPanel.visible = false
		$Bot_6/BotPanel/BotSpeechBubble.visible = false

func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://cafeteria.tscn")

func _process(delta):
	if speech_zone == true and Input.is_action_just_pressed("accept"):
		get_tree().change_scene_to_file("res://cellar.tscn")
