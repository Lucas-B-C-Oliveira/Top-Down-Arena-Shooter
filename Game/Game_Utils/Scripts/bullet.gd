extends Area2D

var speed = 1000
var dir = Vector2(0 , -1)

var my_pattern  = ""

func _ready():
	pass 

func _process(delta):
	if GAME_MANAGER.game_mode == "pause":
		return
	elif GAME_MANAGER.game_mode == "run":
		translate((dir * speed) * delta)


func _on_notifier2D_screen_exited():
	queue_free()

func self_destroy():
	self.queue_free()

func set_size(scale_vec):
	global_scale += scale_vec