extends KinematicBody2D

var target_player
var speed = 25
var dir = Vector2(0 , -1)

var im_ready : bool = false
var timer_to_start = 1

var life_to_stop = false
var number_of_dies = 0

var timer_to_ready

var id : int 

func _ready():
	pass # Replace with function body.

func _process(delta):
	
	if GAME_MANAGER.followers_enemys_die >= GAME_MANAGER.followers_enemys_count:
		return
	
	if life_to_stop:
		number_of_dies += 1
	
	
	if number_of_dies == 3:
		GAME_MANAGER.followers_enemys_die += 1
		print("EU MORRI")
		return
	
	if GAME_MANAGER.start_game:
		timer_to_ready = Timer.new()
		timer_to_ready.connect("timeout", self ,"_on_timer_timeout") 
		add_child(timer_to_ready) #to process
		timer_to_ready.one_shot = true
		timer_to_ready.start(1 + timer_to_start) #to start
		if im_ready:
			
			life_to_stop = false
			
			number_of_dies = 0
			
			if GAME_MANAGER.game_mode == "pause":
				pass
			elif GAME_MANAGER.game_mode == "run":
				look_at(GAME_MANAGER.player1_Instance.global_position)
				dir = GAME_MANAGER.player1_Instance.global_position - global_position
				move_and_slide((dir * speed) * delta) # Quando o inimigo chega perto, ele diminui a velocidade
				## a distancia começa a ficar menor, entao o dir fica menor e na multiplicação, faz a velocidade
				## da nave inimiga ficar melhor, procurar uma maneira de corrigir!


func _on_timer_timeout():
	im_ready = true


func change_position():
	var left_or_right = randi()%2+1
	var random_position = randi()%3+1
	
	if left_or_right == 1:
		## Left
		
		match random_position:
			1:
				global_position = Vector2(-134.955 , 45.035)
			2:
				global_position = Vector2(-134.955 , 352.116)
			3:
				global_position = Vector2(-134.955 , 948.525)
	else:
		## Right
		
		match random_position:
			1:
				global_position = Vector2(2056.29 , 188.19)
			2:
				global_position = Vector2(2056.29 , 516.908)
			3:
				global_position = Vector2(2056.29 , 734.658)


func gift_the_player(bullet):
	if bullet.my_pattern == "player1":
		GAME_MANAGER.player1_Instance.exp_bar += 2 / GAME_MANAGER.exp_division
	elif bullet.my_pattern == "player2":
			GAME_MANAGER.player2_Instance.exp_bar += 2 / GAME_MANAGER.exp_division


func _on_area_body_entered(body):
	pass

func _on_area_area_entered(bullet):
	
	
	###
	
	# Setar a posição para fora do mapa
		# gerar um random
		# dependendo do random vai para esquerda ou direita e sempre apontando para o lado oposto
		
	# Dar a recompensa para o player
		# dar EXP
	
	# Dizer para o Game_Manager que este personagem morreu e que ele deve ficar inativo até a próxima wave
	
	
	###
	if bullet.has_method("self_destroy"):
		bullet.self_destroy()
		life_to_stop = true
		
		change_position()
		gift_the_player(bullet)
		
		timer_to_ready.one_shot = true
		timer_to_ready.start(1 + timer_to_start) #to start
		
		##### BUFFS
		
		speed += 10 * number_of_dies
	
