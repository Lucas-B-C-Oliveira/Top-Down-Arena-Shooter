extends KinematicBody2D


var left_or_right: int
var my_direction
var dir = Vector2(0 , -1)
var speed = 10

var timer_to_ready
var timer_to_start = 1

var im_active : bool = true

var number_of_dies = 0
var number_of_max_dies = 3

var direction = 1

var id : int 

var im_ready_to_move : bool = false

var col_with_player = false

var im_leader = false

var im_follow_one_leader = false

var my_leader


func _process(delta):
	
	if number_of_dies >= number_of_max_dies:
		GAME_MANAGER.lerp_enemys_die += 1
		number_of_dies = 0
		print("Enemy2 Morreu: " , "Vidas perdidas: " , number_of_dies)
		return
	
	if not im_active:
		return
	
	if GAME_MANAGER.start_game and not GAME_MANAGER.game_win:
		timer_to_ready = Timer.new()
		timer_to_ready.set_one_shot(true)
		timer_to_ready.connect("timeout", self ,"_on_ready_timer_timeout") 
		add_child(timer_to_ready) #to process
		timer_to_ready.start(1 + timer_to_start) #to start
		
		if im_ready_to_move:
			if GAME_MANAGER.game_mode == "pause":
				pass
			elif GAME_MANAGER.game_mode == "run":
				if not im_follow_one_leader or im_leader:
					look_at(dir)
					move_and_slide((dir * speed) * delta)
				else:
					look_at(dir)
					move_and_slide((dir * speed) * delta)


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


func change_dir():
	left_or_right = randi()%2+1
	var random_position = randi()%3+1
	
	if left_or_right == 1:
		## Left
		
		match random_position:
			1:
#				global_position = Vector2(-134.955 , 45.035)
				dir = Vector2(2056.29 , 188.19)
			2:
#				global_position = Vector2(-134.955 , 352.116)
				dir = Vector2(2056.29 , 516.908)
			3:
#				global_position = Vector2(-134.955 , 948.525)
				dir = Vector2(2056.29 , 734.658)
	else:
		## Right
		
		match random_position:
			1:
#				global_position = Vector2(2056.29 , 188.19)
				dir = Vector2(-134.955 , 45.035)
			2:
#				global_position = Vector2(2056.29 , 516.908)
				dir = Vector2(-134.955 , 352.116)
			3:
#				global_position = Vector2(2056.29 , 734.658)
				dir = Vector2(-134.955 , 948.525)
	my_direction = dir - global_position


func fuzzy_to_damaged_in_player():
	var chance = randi() % 100 + 1
	var damaged: int = 0
	
	if chance > 93:
		damaged = 3
	elif chance > 83 and chance <= 93:
		damaged = 2
	elif chance > 50 and chance <= 83:
		damaged = 1.5
	elif chance <= 50:
		damaged = 1
	
	return damaged


func fuzzy_to_damaged_in_enemy():
	var chance = randi() % 100 + 1
	var damaged: int = 0
	
	if chance > 93:
		damaged = 3
	elif chance > 83 and chance <= 93:
		damaged = 2
	elif chance > 50 and chance <= 83:
		damaged = 0
	elif chance <= 50:
		damaged = 1
	
	return damaged


func gift_the_player(bullet):
	if bullet.my_pattern == "player1":
		GAME_MANAGER.player1_Instance.exp_bar += 2 / GAME_MANAGER.exp_division
#		GAME_MANAGER.player1_Instance.exp_bar += 50 # Comente esta linha para teste
	elif bullet.my_pattern == "player2":
			GAME_MANAGER.player2_Instance.exp_bar += 2 / GAME_MANAGER.exp_division


func follow_the_leader():
	dir = my_leader.dir


func _on_Timer_timeout():
	if im_leader or not im_follow_one_leader:
		change_dir()

func _on_ready_timer_timeout():
	if number_of_dies < number_of_max_dies:
		im_ready_to_move = true
	else:
		im_active = false


func _on_area_to_IA_body_entered(body):
	if not im_leader and not im_follow_one_leader:
		if body.im_leader:
			im_follow_one_leader = true
			my_leader = body
			follow_the_leader()

func _on_area_to_IA_body_exited(body):
	if body.has_method("take_damage"):
		col_with_player = false


func _on_area_to_damaged_body_entered(body):
	if body.has_method("take_damage"):
		var damaged = fuzzy_to_damaged_in_player()
		body.take_damage(damaged)
		change_position()
		
		timer_to_ready.one_shot = true
		timer_to_ready.start(1)

			##### BUFFS IN ENEMY
			
		speed += 0.3 * number_of_dies
		print("Encostou no player")


func _on_area_to_damaged_area_entered(area):
	if area.has_method("self_destroy"):
		if number_of_dies < 3:
			area.self_destroy()
			var damaged = fuzzy_to_damaged_in_enemy()
			number_of_dies += damaged
			
			change_position()
			gift_the_player(area)
			
			timer_to_ready.one_shot = true
			timer_to_ready.start(1 + timer_to_start) #to start
			
			##### BUFFS IN ENEMY
			
			speed += 0.3 * number_of_dies
