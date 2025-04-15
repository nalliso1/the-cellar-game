extends Area2D

@export var speech_bubble: NodePath  
@export var next_scene: PackedScene  
const cafScene = preload("res://topDownRooms/cafeteria.tscn")

var bubble_ref: Node = null
var player_inside: bool = false  

func _ready():

	if speech_bubble:
		bubble_ref = get_node(speech_bubble)
		bubble_ref.hide()  

func _on_body_entered(body):
	if body.name == "player":  
		bubble_ref.show()
		player_inside = true 

func _on_body_exited(body):
	if body.name == "player":
		bubble_ref.hide()
		player_inside = false  

func _process(delta):
	if player_inside and Input.is_action_just_pressed("ui_up"):  # Assuming 'interact' is mapped to 'e'
		next_scene = cafScene
		get_tree().change_scene_to_packed(next_scene)
