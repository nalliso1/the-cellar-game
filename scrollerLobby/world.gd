extends Node

var current_scene = null
var previous_scenes = []
var camera_paths = {
	"res://scrollerLobby/world.tscn": "Player/ScrollerCamera",
	"res://topDownRooms/cellar.tscn": "Player/CellarCamera",
	"res://topDownRooms/cafeteria.tscn": "Player/CafeteriaCamera",
	"res://topDownRooms/sclub.tscn": "Player/SClubCamera",
	"res://games/rideTheBus/ride_the_bus.tscn": "RideTheBusCamera",
	"res://games/pong/main.tscn": "PongCamera",
	"res://games/horseRacing/horse_racing.tscn": "HorseRacingCamera"
}

func _ready() -> void:
	current_scene = get_tree().current_scene
	current_scene.name = "World"

func change_scene_to(path: String):
	if current_scene:
		setProcesses(false)
		previous_scenes.append(current_scene)
		current_scene.set_process(false)
		current_scene.set_physics_process(false)
		current_scene.visible = false
		

	print("the path sent is: " + path)
	var new_scene = load(path).instantiate()

	if path == "res://topDownRooms/cellar.tscn":
		new_scene.name = "Cellar"
	elif path == "res://topDownRooms/cafeteria.tscn":
		new_scene.name = "Sub"
	elif path == "res://topDownRooms/sclub.tscn":
		new_scene.name = "Sclub"
	elif path == "res://games/rideTheBus/ride_the_bus.tscn":
		new_scene.name = "RideTheBus"
	elif path == "res://games/pong/main.tscn":
		new_scene.name = "Pong"
	elif path == "res://games/horseRacing/horse_racing.tscn":
		new_scene.name = "HorseRacing"

	get_tree().root.add_child(new_scene)
	current_scene = new_scene
	get_tree().current_scene = current_scene
	print("in the " + current_scene.name)

	switch_camera(path)

func switch_camera(path: String):
	if camera_paths.has(path):
		var camera_path = camera_paths[path]
		var camera = current_scene.get_node_or_null(camera_path)
		
		if camera and camera is Camera2D:
			camera.make_current()
			print("Switched to camera: " + camera_path)
		else:
			print("No Camera2D found at: " + camera_path)
	else:
		print("No camera path defined for this scene.")


func return_to_previous_scene():
	if current_scene:
		current_scene.queue_free()

	if previous_scenes.size() > 0:
		var previous = previous_scenes.pop_back()
		previous.visible = true
		previous.set_process(true)
		previous.set_physics_process(true)
		current_scene = previous
		get_tree().current_scene = current_scene
		setProcesses(true)



func setProcesses(trueOrFalse):
	print(current_scene.name + " set processes " + str(trueOrFalse))
	if current_scene.get_node_or_null("Backgrounds/CellarDoor/Area2D") != null:
		current_scene.get_node("Backgrounds/CellarDoor/Area2D").set_physics_process(trueOrFalse)
		current_scene.get_node("Backgrounds/CellarDoor/Area2D").set_process(trueOrFalse)
	if current_scene.get_node_or_null("Backgrounds/SubDoor/Area2D") != null:
		current_scene.get_node("Backgrounds/SubDoor/Area2D").set_physics_process(trueOrFalse)
		current_scene.get_node("Backgrounds/SubDoor/Area2D").set_process(trueOrFalse)
	if current_scene.get_node_or_null("Backgrounds/SclubDoor/Area2D") != null:
		current_scene.get_node("Backgrounds/SclubDoor/Area2D").set_physics_process(trueOrFalse)
		current_scene.get_node("Backgrounds/SclubDoor/Area2D").set_process(trueOrFalse)
	if current_scene.get_node_or_null("Player") != null:
		current_scene.get_node("Player").set_physics_process(trueOrFalse)
		current_scene.get_node("Player").set_process(trueOrFalse)
		if trueOrFalse:
			current_scene.get_node("Player").collision_layer = 1
		else: 
			current_scene.get_node("Player").collision_layer = 2
			
	if current_scene.get_node_or_null("Bot") != null:
		current_scene.get_node("Bot").set_physics_process(trueOrFalse)
		current_scene.get_node("Bot").set_process(trueOrFalse)
	if current_scene.get_node_or_null("Bot2") != null:
		current_scene.get_node("Bot2").set_physics_process(trueOrFalse)
		current_scene.get_node("Bot2").set_process(trueOrFalse)
	if current_scene.get_node_or_null("Bot_3") != null:
		current_scene.get_node("Bot_3").set_physics_process(trueOrFalse)
		current_scene.get_node("Bot_3").set_process(trueOrFalse)
	if current_scene.get_node_or_null("Bot_4") != null:
		current_scene.get_node("Bot_4").set_physics_process(trueOrFalse)
		current_scene.get_node("Bot_4").set_process(trueOrFalse)
	if current_scene.get_node_or_null("Bot_5") != null:
		current_scene.get_node("Bot_5").set_physics_process(trueOrFalse)
		current_scene.get_node("Bot_5").set_process(trueOrFalse)
	if current_scene.get_node_or_null("Bot_6") != null:
		current_scene.get_node("Bot_6").set_physics_process(trueOrFalse)
		current_scene.get_node("Bot_6").set_process(trueOrFalse)
	if current_scene.get_node_or_null("Dealer") != null:
		current_scene.get_node("Dealer").set_physics_process(trueOrFalse)
		current_scene.get_node("Dealer").set_process(trueOrFalse)
	if current_scene.get_node_or_null("dealer_race") != null:
		current_scene.get_node("dealer_race").set_physics_process(trueOrFalse)
		current_scene.get_node("dealer_race").set_process(trueOrFalse)
	if current_scene.get_node_or_null("PingPongPlayer") != null:
		current_scene.get_node("PingPongPlayer").set_physics_process(trueOrFalse)
		current_scene.get_node("PingPongPlayer").set_process(trueOrFalse)
