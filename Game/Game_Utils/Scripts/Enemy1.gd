extends KinematicBody2D

var target_player
var vel = 25
var dir = Vector2(0 , -1)

func _ready():
	pass # Replace with function body.

func _process(delta):
	if GAME_MANAGER.game_mode == "pause":
		pass
	elif GAME_MANAGER.game_mode == "run":
		look_at(GAME_MANAGER.player1_Instance.global_position)
		dir = GAME_MANAGER.player1_Instance.global_position - global_position
		move_and_slide(dir * vel * delta) # Quando o inimigo chega perto, ele diminui a velocidade
		## a distancia começa a ficar menor, entao o dir fica menor e na multiplicação, faz a velocidade
		## da nave inimiga ficar melhor, procurar uma maneira de corrigir!
