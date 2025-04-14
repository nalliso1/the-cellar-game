extends Node2D

var speech_zone = false

func _on_bot_3_area_body_entered(body):
	if body.is_in_group("player"):
		$Bot_3/BotPanel.visible = true
		$Bot_3/BotPanel/BotSpeechBubble.visible = true

func _on_bot_3_area_body_exited(body):
	if body.is_in_group("player"):
		$Bot_3/BotPanel.visible = false
		$Bot_3/BotPanel/BotSpeechBubble.visible = false

func _on_bot_4_area_body_entered(body):
	if body.is_in_group("player"):
		$Bot_4/BotPanel.visible = true
		$Bot_4/BotPanel/BotSpeechBubble.visible = true

func _on_bot_4_area_body_exited(body):
	if body.is_in_group("player"):
		$Bot_4/BotPanel.visible = false
		$Bot_4/BotPanel/BotSpeechBubble.visible = false

func _on_speech_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$PingPongPanel.visible = true
		$PingPongPanel/PingPongSpeechBubble.visible = true
		speech_zone = true

func _on_speech_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$PingPongPanel.visible = false
		$PingPongPanel/PingPongSpeechBubble.visible = false
		speech_zone = false

func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://sclub.tscn")

func _process(delta):
	if speech_zone == true and Input.is_action_just_pressed("accept"):
		get_tree().change_scene_to_file("res://cellar.tscn")
