extends Control

@onready var lane1 = $VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/Lane
@onready var lane2 = $VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer2/Lane
@onready var lane3 = $VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer3/Lane
@onready var lane4 = $VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer4/Lane

@onready var cardHolder = $VBoxContainer/HBoxContainer/TextureRect

var lane1Position
var lane2Position
var lane3Position
var lane4Position

var suitChoice
var suitChar

const cardScene = preload("res://games/materialsForHorseAndBus/card.tscn")

var cardImagePaths
var cardImagePathsLength

var aceOfHearts
var aceOfSpades
var aceOfDiamonds
var aceOfClubs

signal win
signal lose

func _ready() -> void:
	$VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer.visible = false
	$VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer2.visible = false
	$VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer3.visible = false
	$VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer4.visible = false
	
func readyTheHorses():
	$VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer.visible = true
	$VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer2.visible = true
	$VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer3.visible = true
	$VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer4.visible = true
	
	$VBoxContainer/Label.text = "You selected " + str(suitChoice) + "s"
	
	$StartGameSound.play()
	$finishline.visible = true
	
	
	getAllCardImagePaths()
	
	#set the aces
	lane1Position = 1
	lane2Position = 1
	lane3Position = 1 
	lane4Position = 1
	

	
	aceOfHearts = createCard("h01.png")
	aceOfSpades = createCard("s01.png")
	aceOfDiamonds = createCard("d01.png")
	aceOfClubs = createCard("c01.png")
	

	
	lane1.get_node("Spot" + str(lane1Position)).add_child(aceOfHearts)
	lane2.get_node("Spot" + str(lane2Position)).add_child(aceOfSpades)
	lane3.get_node("Spot" + str(lane3Position)).add_child(aceOfDiamonds)
	lane4.get_node("Spot" + str(lane4Position)).add_child(aceOfClubs)
	
	$SelectionWindow.visible = false
	await get_tree().create_timer(1).timeout
	nextCard()


func nextCard():
	
	
	var nextCardToAdd = createCard("") 
	cardHolder.texture = nextCardToAdd.get_node("FrontOfCard").texture
	
	match suitChar: 
		"h":
			lane1.get_node("Spot" + str(lane1Position)).remove_child(aceOfHearts)
			lane1Position += 1
			lane1.get_node("Spot" + str(lane1Position)).add_child(aceOfHearts)
			await get_tree().create_timer(0.5).timeout
			if lane1Position == 13:
				if suitChoice == "Heart":
					winner()
				else:
					loser()
			else:
				nextCard()
			
		"s": 
			lane2.get_node("Spot" + str(lane2Position)).remove_child(aceOfSpades)
			lane2Position += 1
			lane2.get_node("Spot" + str(lane2Position)).add_child(aceOfSpades)
			await get_tree().create_timer(0.5).timeout
			if lane2Position == 13:
				if suitChoice == "Spade":
					winner()
				else:
					loser()
			else:
				nextCard()

		"d":
			lane3.get_node("Spot" + str(lane3Position)).remove_child(aceOfDiamonds)
			lane3Position += 1
			lane3.get_node("Spot" + str(lane3Position)).add_child(aceOfDiamonds)
			await get_tree().create_timer(0.5).timeout
			if lane3Position == 13:
				if suitChoice == "Diamond":
					winner()
				else:
					loser()
			else:
				nextCard()
		"c":
			lane4.get_node("Spot" + str(lane4Position)).remove_child(aceOfClubs)
			lane4Position += 1
			lane4.get_node("Spot" + str(lane4Position)).add_child(aceOfClubs)
			await get_tree().create_timer(0.5).timeout
			if lane4Position == 13:
				if suitChoice == "Club":
					winner()
				else:
					loser()
			else:
				nextCard()
				
	


func createCard(cardImageName) -> Node2D:
	
	var curCard = cardScene.instantiate()	
	var fullCardPath 

	
	if cardImageName != "":
	
		fullCardPath = str("res://games/materialsForHorseAndBus/cardImages/" + cardImageName)
		cardImagePaths.erase(cardImageName)
		suitChar = cardImageName.substr(0,1)
		
	else: 
		
		cardImagePathsLength = cardImagePaths.size()
		var rng = RandomNumberGenerator.new()		
		var randomVal = rng.randi_range(0,cardImagePathsLength -1)	
		var curCardImagePath = cardImagePaths[randomVal]
		
		fullCardPath = str("res://games/materialsForHorseAndBus/cardImages/" + curCardImagePath)
		cardImagePaths.erase(curCardImagePath)		
		suitChar = curCardImagePath.substr(0,1)
		

	var frontOfCurCard = curCard.get_node("FrontOfCard")
	frontOfCurCard.texture = load(fullCardPath)			
	frontOfCurCard.scale = Vector2(0.075, 0.075)
	
	
	var backOfCurCard = curCard.get_node("BackOfCard")
	backOfCurCard.visible = false	
	
	curCard.position.x = 25
	curCard.position.y = 40
	
	return curCard


func getAllCardImagePaths(): 
	cardImagePaths = []	
	var directory = DirAccess.open("res://games/materialsForHorseAndBus/cardImages") 
	
	directory.list_dir_begin()
	var currentPath = directory.get_next()
	
	while currentPath != "":
		if !currentPath.ends_with(".import"):
			cardImagePaths.append(currentPath)
		currentPath = directory.get_next()
	
	directory.list_dir_end()


	
func winner():
	$WinSound.play()
	win.emit()
	$VBoxContainer/Label.text = "You win"
	await get_tree().create_timer(3).timeout
	WorldScript.return_to_previous_scene()
	
func loser(): 
	$LoseSound.play()
	lose.emit()
	$VBoxContainer/Label.text = "You picked the wrong suit"
	await get_tree().create_timer(3).timeout
	WorldScript.return_to_previous_scene()

func _on_button_1_pressed() -> void:
	suitChoice = "Heart"
	readyTheHorses()
	
func _on_button_2_pressed() -> void:
	suitChoice = "Spade"
	readyTheHorses()


func _on_button_3_pressed() -> void:
	suitChoice = "Diamond"
	readyTheHorses()

func _on_button_4_pressed() -> void:
	suitChoice = "Club"
	readyTheHorses()
