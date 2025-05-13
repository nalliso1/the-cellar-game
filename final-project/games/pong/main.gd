extends Sprite2D

var gameOver = false

var score := [-1, -1]
var can_score := true

const player_paddle_speed: int = 500
const cpu_paddle_speed: int = 300
const max_score: int = 3 

@onready var win_point = $ScoreRight/WinPoint  
@onready var lose_point = $ScoreLeft/LosePoint 

func _ready() -> void:
	gameOver = false
	$BallTimer.wait_time = 2

func _on_score_left_body_entered(body: Node2D) -> void:
	if can_score:
		can_score = false
		lose_point.play()
		score[1] += 1
		$Hud/CPUScore.text = str(score[1])
		check_game_over()
		$Ball.hide_and_pause()  # Hide and pause the ball
		$BallTimer.start()

func _on_score_right_body_entered(body: Node2D) -> void:
	if can_score:
		can_score = false
		win_point.play()
		score[0] += 1
		$Hud/PlayerScore.text = str(score[0])
		check_game_over()
		$Ball.hide_and_pause()  # Hide and pause the ball
		$BallTimer.start()

func _on_ball_timer_timeout() -> void:
	can_score = true
	$Ball.new_ball()  # Reset ball after 3 sec pause

func check_game_over() -> void:
	if gameOver == true:
		return
	
	if score[0] >= max_score:
		gameOver = true
		WorldScript.won_pong = true
		$Hud.visible = false
		WorldScript.return_to_previous_scene()
	
	if score[1] >= max_score:
		gameOver = true
		WorldScript.return_to_previous_scene()
