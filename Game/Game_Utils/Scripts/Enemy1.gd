extends KinematicBody2D

var target_player
var speed = 25
var dir = Vector2(0 , -1)

var im_ready : bool = false
var timer_to_start = 1

var lifes_to_stop = [false , false , false]
var number_of_dies = 0

var timer_to_ready

func _ready():
	pass # Replace with function body.

func _process(delta):
	
	for i in lifes_to_stop:
		if i:
			GAME_MANAGER.followers_enemys_die += 1
			number_of_dies += 1
	
	if GAME_MANAGER.followers_enemys_die == GAME_MANAGER.followers_enemys_count:
		return
	
	if number_of_dies == 3:
		return
	
	if GAME_MANAGER.start_game:
		timer_to_ready = Timer.new()
		timer_to_ready.connect("timeout", self ,"_on_timer_timeout") 
		add_child(timer_to_ready) #to process
		timer_to_ready.one_shot = true
		timer_to_ready.start(1 + timer_to_start) #to start
		if im_ready:
			
			for i in lifes_to_stop:
				if i:
					i = false
			
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




func _on_area_body_entered(body):
	pass # Replace with function body.


func _on_area_area_entered(area):
	if area.has_method("self_destroy"):
		area.self_destroy()
		lifes_to_stop.pop_back()
		lifes_to_stop.push_front(true)
		
		if area.my_pattern == "player1":
			GAME_MANAGER.player1_Instance.exp_bar += 2 / GAME_MANAGER.exp_division
		elif area.my_pattern == "player2":
			GAME_MANAGER.player2_Instance.exp_bar += 2 / GAME_MANAGER.exp_division
		
		var random_position = randi()%5+1
		
		match random_position:
			1:
				global_position = Vector2(2169.418, -114.053)
			2:
				global_position = Vector2(-143.394, -114.053)
			3:
				global_position = Vector2(-143.394, 1176.169)
			4:
				global_position = Vector2(2061.567, 1180.163)
			_:
				global_position = Vector2(2169.418, -114.053)
		
		timer_to_ready.one_shot = true
		timer_to_ready.start(1 + timer_to_start) #to start
		
		##### BUFFS
		
		speed += 10 * number_of_dies
	
