extends Sprite2D

var score := [0, 0]
const player_paddle_speed: int = 500
const cpu_paddle_speed: int = 300
const max_score: int = 3  

@onready var win_point = $ScoreRight/WinPoint  
@onready var lose_point = $ScoreLeft/LosePoint 

func _on_ball_timer_timeout() -> void:
	$Ball.new_ball()

func _on_score_left_body_entered(body: Node2D) -> void:
	lose_point.play()
	score[1] += 1
	$Hud/CPUScore.text = str(score[1])
	check_game_over()  
	$BallTimer.start()

func _on_score_right_body_entered(body: Node2D) -> void:
	win_point.play()
	score[0] += 1
	$Hud/PlayerScore.text = str(score[0])
	check_game_over()  
	$BallTimer.start()

func check_game_over() -> void:
	if score[0] >= max_score or score[1] >= max_score:
		await get_tree().create_timer(3).timeout
		WorldScript.return_to_previous_scene()
