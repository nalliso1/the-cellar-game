extends StaticBody2D

var win_height : int
var p_height : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().player_paddle_speed * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += get_parent().player_paddle_speed * delta

	# Clamp the paddle's position to ensure it doesn't go beyond the screen edges
	position.y = clamp(position.y, 0,600)
