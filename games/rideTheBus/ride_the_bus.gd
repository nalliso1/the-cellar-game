extends Control

@onready var button1 = $VBoxContainer/ButtonContainer/Button1
@onready var button2 = $VBoxContainer/ButtonContainer/Button2
@onready var button3 = $VBoxContainer/ButtonContainer/Button3
@onready var button4 = $VBoxContainer/ButtonContainer/Button4

@onready var card1Place = $VBoxContainer/CardContainer/Card1
@onready var card2Place = $VBoxContainer/CardContainer/Card2
@onready var card3Place = $VBoxContainer/CardContainer/Card3
@onready var card4Place = $VBoxContainer/CardContainer/Card4

@export var prev_scene: PackedScene  
#const cellarScene = preload("res://topDownRooms/cellar.tscn")
const cardScene = preload("res://games/card.tscn")


var questionNumber
var cardImagePaths
var cardImagePathsLength

var currentRun
var emptyRun

var startGameSound
signal win
signal lose

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	

	
	emptyRun = [{"cardScene": -1, "suit" : -1, "number" : -1},
				  {"cardScene": -1, "suit" : -1, "number" : -1},
				  {"cardScene": -1, "suit" : -1, "number" : -1},
				  {"cardScene": -1, "suit" : -1, "number" : -1}]
	
	currentRun = emptyRun.duplicate(true)		
	$StartGameSound.play()
	
	await get_tree().create_timer(3).timeout
	#var cellarScene = preload("res://topDownRooms/cellar.tscn")
	var err = get_tree().change_scene_to_packed(prev_scene)
	print(err)
	questionNumber = 1
	getAllCardImagePaths()	
	redOrBlack()



func updateGameState(): 
	createCard()
	#set card details
	setCardDetails()

	
	
	
func loser():
	$VBoxContainer/OptionLabel.text = "you ran out of cards"
	$LoseSound.play()
	disableButtons(true)
	lose.emit() #connect this to the main scroller Lobby stuff to keep track of wins and loses

	#await get_tree().create_timer(3).timeout
	#prev_scene = cellarScene
	#get_tree().change_scene_to_packed(prev_scene)

func winner():
	$VBoxContainer/OptionLabel.text = "winner"
	$WinSound.play()
	disableButtons(true)
	win.emit()
	await get_tree().create_timer(3).timeout
	#prev_scene = cellarScene 
	var cellarScene = preload("res://topDownRooms/cellar.tscn")
	get_tree().change_scene_to_packed(cellarScene)


func disableButtons(on):
	$VBoxContainer/ButtonContainer/Button1.disabled = on
	$VBoxContainer/ButtonContainer/Button2.disabled = on
	$VBoxContainer/ButtonContainer/Button3.disabled = on
	$VBoxContainer/ButtonContainer/Button4.disabled = on

func niceTryAnimation():
	pass
	
	
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



func setCardDetails():
	cardImagePathsLength = cardImagePaths.size()
	
	if cardImagePathsLength == 0: 
		loser()
		
	var rng = RandomNumberGenerator.new()		
	var randomVal = rng.randi_range(0,cardImagePathsLength -1)	
	var curCardImagePath = cardImagePaths[randomVal]
	
	cardImagePaths.erase(curCardImagePath)

	var suitChar = curCardImagePath.substr(0,1)
	var num = int(curCardImagePath.substr(1,3))
	currentRun[questionNumber -1]["suit"] = suitChar
	currentRun[questionNumber -1]["number"] = num
	
	
	var fullCardPath = str("res://games/materialsForHorseAndBus/cardImages/" + curCardImagePath)

	
	var frontOfCurCard = currentRun[questionNumber -1]["cardScene"].get_node("FrontOfCard")
	frontOfCurCard.texture = load(fullCardPath)
	
	
	
	var backOfCurCard = currentRun[questionNumber -1]["cardScene"].get_node("BackOfCard")
	backOfCurCard.visible = false
	

	
	
func createCard():
	
	var placementPath 
	match questionNumber:
		1:
			placementPath = card1Place
		2:
			placementPath = card2Place
		3:
			placementPath = card3Place
		4:
			placementPath = card4Place

	var curCard = cardScene.instantiate()
	
	placementPath.add_child(curCard)	
	currentRun[questionNumber - 1]["cardScene"] = curCard
	currentRun[questionNumber - 1]["cardScene"].position.x = 55
	currentRun[questionNumber - 1]["cardScene"].position.y = 80

	
	
func goodGuess(): 
	$VBoxContainer/OptionLabel.text = "Nice Guess"
	
func badGuess():
	$VBoxContainer/OptionLabel.text = "get em next time..."
	
func resetRun(questionNum):

	badGuess()
	questionNumber = 0	
	var placementPath 
	disableButtons(true)
	$LoseSound.play()
	await get_tree().create_timer(1.5).timeout
	disableButtons(false)

	for i in range(questionNum):
		match i:
			0:
				placementPath = card1Place
			1:
				placementPath = card2Place
			2:
				placementPath = card3Place
			3:
				placementPath = card4Place
			
		var deleteCard = placementPath.get_node("Card")
		placementPath.remove_child(deleteCard)
		deleteCard.queue_free()
	
	currentRun = emptyRun.duplicate(true)	
	redOrBlack()

func _on_button_2_pressed() -> void:
	
	updateGameState()

	
	match questionNumber:
		1: 
			if currentRun[0]["suit"] == "h" or currentRun[0]["suit"] == "d":
				higherOrLower()
			else:
				resetRun(1)	
		2:
			if currentRun[1]["number"] > currentRun[0]["number"]:
				insideOrOutside()
			else:
				resetRun(2)
		3: 
			if currentRun[2]["number"] < currentRun[1]["number"] and currentRun[2]["number"] > currentRun[0]["number"] or currentRun[2]["number"] > currentRun[1]["number"] and currentRun[2]["number"] < currentRun[0]["number"]:
				pickASuit()
			else:
				resetRun(3)
		4:
			if currentRun[3]["suit"] == "s":
				winner()
			else:
				niceTryAnimation() 
				resetRun(4)

	
	
	#update question number
	questionNumber += 1
	#show card
		#make card 
		#make animationg occur from deck
		#if they were right continue
		#else animate the cards being wiped off the screen


func _on_button_3_pressed() -> void:
	
	updateGameState()
	
	match questionNumber:
		1: 
			if currentRun[0]["suit"] == "s" or currentRun[0]["suit"] == "c":
				higherOrLower()
			else:
				resetRun(1)	
		2:
			if currentRun[1]["number"] < currentRun[0]["number"]:
				insideOrOutside()
			else:
				resetRun(2)
		3: 
			if currentRun[2]["number"] > currentRun[1]["number"] and currentRun[2]["number"] > currentRun[0]["number"] or currentRun[2]["number"] < currentRun[1]["number"] and currentRun[2]["number"] < currentRun[0]["number"]:
				pickASuit()
			else:
				resetRun(3)
		4:
			if currentRun[3]["suit"] == "d":
				winner()
			else:
				niceTryAnimation()
				resetRun(4)
	
	
	questionNumber += 1

#thers buttons are only used in the last question pickASuit
func _on_button1_pressed() -> void:
	
	updateGameState()

	if questionNumber == 4 and currentRun[3]["suit"] == "h": 
		winner()
	else:
		resetRun(4)
	
	questionNumber += 1

func _on_button_4_pressed() -> void:
	updateGameState()

	
	if questionNumber == 4 and currentRun[3]["suit"] == "c": 
		winner()	
	else:
		resetRun(4)
	questionNumber += 1








#---------------------------------------------------------------------------------
#these functions set the buttons so we can work with them


func redOrBlack(): 
	button1.visible = false
	button2.visible = true
	button3.visible = true
	button4.visible = false

	button2.text = "Red"
	#button2.add_theme_color_override("font_color", Color(1,0,0))
	button3.text = "Black"
	#button3.add_theme_color_override("font_color", Color(0,0,0))
	
	
func higherOrLower(): 
	button1.visible = false
	button2.visible = true
	button3.visible = true
	button4.visible = false

	button2.text = "Higher"
	#button2.add_theme_color_override("font_color", Color(1,1,1))
	button3.text = "Lower"
	#button3.add_theme_color_override("font_color", Color(0,0,0))
	goodGuess()


func insideOrOutside(): 
	button1.visible = false
	button2.visible = true
	button3.visible = true
	button4.visible = false

	button2.text = "Inside"
	#button2.add_theme_color_override("font_color", Color(1,1,1))
	button3.text = "Outside"
	#button3.add_theme_color_override("font_color", Color(0,0,0))
	goodGuess()
	
func pickASuit(): 
	button1.visible = true
	button2.visible = true
	button3.visible = true
	button4.visible = true

	button1.text = "Heart"
	#button2.add_theme_icon_override("heartImage", )
	button2.text = "Spade"
	#button3.add_theme_color_override("font_color", Color(0,0,0))
	button3.text = "Diamond"
	#button2.add_theme_color_override("font_color", Color(1,1,1))
	button4.text = "Club"
	#button3.add_theme_color_override("font_color", Color(0,0,0))
	goodGuess()
