extends Node2D

var speech_zone = false

func _on_speech_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$DealerPanel.visible = true
		$DealerPanel/DealerSpeechBubble.visible = true
		speech_zone = true

func _on_speech_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$DealerPanel.visible = false
		$DealerPanel/DealerSpeechBubble.visible = false
		speech_zone = false

func _on_bot_area_body_entered(body):
	if body.is_in_group("player"):
		$Bot/BotPanel.visible = true
		$Bot/BotPanel/BotSpeechBubble.visible = true

func _on_bot_area_body_exited(body):
	if body.is_in_group("player"):
		$Bot/BotPanel.visible = false
		$Bot/BotPanel/BotSpeechBubble.visible = false

func _on_bot_2_area_body_entered(body):
	if body.is_in_group("player"):
		$Bot2/BotPanel.visible = true
		$Bot2/BotPanel/BotSpeechBubble.visible = true

func _on_bot_2_area_body_exited(body):
	if body.is_in_group("player"):
		$Bot2/BotPanel.visible = false
		$Bot2/BotPanel/BotSpeechBubble.visible = false

func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://cafeteria.tscn")

func _process(delta):
	if speech_zone == true and Input.is_action_just_pressed("accept"):
		get_tree().change_scene_to_file("res://cafeteria.tscn")
