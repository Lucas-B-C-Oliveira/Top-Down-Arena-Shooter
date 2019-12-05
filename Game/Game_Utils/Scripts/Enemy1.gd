extends KinematicBody2D

var target_player
var speed = 15
var dir = Vector2(0 , -1)
var my_direction

var im_ready_to_move : bool = false
var timer_to_start = 1

var number_of_dies = 0
var number_of_max_dies = 3

var timer_to_ready
var im_active : bool = true

var id : int 

var left_or_right: int


func _ready():
	pass # Replace with function body.


func _process(delta):
	
	
	if number_of_dies >= number_of_max_dies:
		GAME_MANAGER.followers_enemys_die += 1
		number_of_dies = 0
		print("Enemy1 Morreu: " , "Vidas perdidas: " , number_of_dies)
		return
	
	if not im_active:
		return
	
	if GAME_MANAGER.start_game and not GAME_MANAGER.game_win:
		timer_to_ready = Timer.new()
		timer_to_ready.set_one_shot(true)
		timer_to_ready.connect("timeout", self ,"_on_timer_timeout") 
		add_child(timer_to_ready) #to process
		timer_to_ready.start(1 + timer_to_start) #to start
		
		if im_ready_to_move:
			
			if GAME_MANAGER.game_mode == "pause":
				pass
			elif GAME_MANAGER.game_mode == "run":
				look_at(dir)
				if left_or_right == 1:
					# Left
					if global_position.x >= my_direction.x:
						change_position()
				else:
					# Right
					if global_position.x <= my_direction.x:
						change_position()
				move_and_slide((my_direction * speed) * delta) # Quando o inimigo chega perto, ele diminui a velocidade
				## a distancia começa a ficar menor, entao o dir fica menor e na multiplicação, faz a velocidade
				## da nave inimiga ficar melhor, procurar uma maneira de corrigir!


func _on_timer_timeout():
	if number_of_dies < number_of_max_dies:
		im_ready_to_move = true
	else:
		im_active = false


## Seta uma posição aleatória e um lado aleatório de acordo com um random
func change_position():
	left_or_right = randi()%2+1
	var random_position = randi()%3+1
	
	if left_or_right == 1:
		## Left
		
		match random_position:
			1:
				global_position = Vector2(-134.955 , 45.035)
				dir = Vector2(2056.29 , 188.19)
			2:
				global_position = Vector2(-134.955 , 352.116)
				dir = Vector2(2056.29 , 516.908)
			3:
				global_position = Vector2(-134.955 , 948.525)
				dir = Vector2(2056.29 , 734.658)
	else:
		## Right
		
		match random_position:
			1:
				global_position = Vector2(2056.29 , 188.19)
				dir = Vector2(-134.955 , 45.035)
			2:
				global_position = Vector2(2056.29 , 516.908)
				dir = Vector2(-134.955 , 352.116)
			3:
				global_position = Vector2(2056.29 , 734.658)
				dir = Vector2(-134.955 , 948.525)
	my_direction = dir - global_position


## Sistema de presente (exp do player)
func gift_the_player(bullet):
	if bullet.my_pattern == "player1":
		GAME_MANAGER.player1_Instance.exp_bar += 2 / GAME_MANAGER.exp_division
#		GAME_MANAGER.player1_Instance.exp_bar += 50 # Comente esta linha para teste
	elif bullet.my_pattern == "player2":
			GAME_MANAGER.player2_Instance.exp_bar += 2 / GAME_MANAGER.exp_division


## Colisão com o player
func _on_area_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(1)
		change_position()
		
		timer_to_ready.one_shot = true
		timer_to_ready.start(1) #to start
		
		##### BUFFS
		
		speed += 0.3 * number_of_dies
		print("Encostou no player")
	pass


## Colisão com a bullet
func _on_area_area_entered(bullet):
	if bullet.has_method("self_destroy"):
		if number_of_dies < 3:
			bullet.self_destroy()
			number_of_dies += 1
			
			change_position()
			gift_the_player(bullet)
			
			timer_to_ready.one_shot = true
			timer_to_ready.start(1 + timer_to_start) #to start
			
			##### BUFFS
			
			speed += 0.3 * number_of_dies


