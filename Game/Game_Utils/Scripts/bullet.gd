extends Area2D

var vel = 300
var dir = Vector2(0 , -1)

func _ready():
	pass 

func _process(delta):
	if GAME_MANAGER.game_mode == "pause":
		return
	elif GAME_MANAGER.game_mode == "run":
		translate(dir * vel * delta)


func _on_notifier2D_screen_exited():
	queue_free()
