extends Control

@onready var lane1 = $VBoxContainer/HBoxContainer/VBoxContainer/Lane1
@onready var lane2 = $VBoxContainer/HBoxContainer/VBoxContainer/Lane2
@onready var lane3 = $VBoxContainer/HBoxContainer/VBoxContainer/Lane3
@onready var lane4 = $VBoxContainer/HBoxContainer/VBoxContainer/Lane4

var lane1Position
var lane2Position
var lane3Position
var lane4Position

var suitChoice

const cardScene = preload("res://card.tscn")

var cardImagePaths
var cardImagePathsLength

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get the card image paths loaded up
	pass

func readyTheHorses():
	getAllCardImagePaths()
	
	#set the aces
	lane1Position = 0
	lane2Position = 0
	lane3Position = 0 
	lane4Position = 0
	
	var aceOfHearts = createCard("h01.png")
	var aceOfSpades = createCard("s01.png")
	var aceOfDiamonds = createCard("d01.png")
	var aceOfClubs = createCard("c01.png")
	

	
	lane1.get_node("Start").add_child(aceOfHearts)
	lane2.get_node("Start").add_child(aceOfSpades)
	lane3.get_node("Start").add_child(aceOfDiamonds)
	lane4.get_node("Start").add_child(aceOfClubs)
	
	startGame()
	

func createCard(cardImageName) -> Node2D:
	
	var curCard = cardScene.instantiate()	
	var fullCardPath 
	var suitChar
	
	if cardImageName != "":
	
		fullCardPath = str("res://materials/cardImages/" + cardImageName)
		cardImagePaths.erase(cardImageName)
		suitChar = cardImageName.substr(0,1)
		
	else: 
		
		cardImagePathsLength = cardImagePaths.size()
		var rng = RandomNumberGenerator.new()		
		var randomVal = rng.randi_range(0,cardImagePathsLength -1)	
		var curCardImagePath = cardImagePaths[randomVal]
		
		fullCardPath = str("res://materials/cardImages/" + curCardImagePath)
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
	var directory = DirAccess.open("res://materials/cardImages") 
	
	directory.list_dir_begin()
	var currentPath = directory.get_next()
	
	while currentPath != "":
		if !currentPath.ends_with(".import"):
			cardImagePaths.append(currentPath)
		currentPath = directory.get_next()
	
	directory.list_dir_end()


func startGame():
	$SelectionWindow.visible = false
	
	
func winner():
	pass
	
func loser(): 
	pass
	

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
