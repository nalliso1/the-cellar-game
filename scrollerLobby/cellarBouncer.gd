extends Area2D

@export var speech_bubble: NodePath  

var bubble_ref: Node = null
var player_inside: bool = false  

func _ready():
	if speech_bubble:
		bubble_ref = get_node(speech_bubble)
		bubble_ref.hide()  

func _on_body_entered(body):
	if body.name == "Player":  
		bubble_ref.show()
		player_inside = true  

func _on_body_exited(body):
	if body.name == "Player":
		bubble_ref.hide()
		player_inside = false  

func _process(_delta):
	if player_inside and Input.is_action_just_pressed("y"):  # Assuming 'interact' is mapped to 'e'
		WorldScript.change_scene_to("res://topDownRooms/cellar.tscn")
