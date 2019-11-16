extends Control

var pre_player1 = preload("res://Game_Utils/Scenes/Player1.tscn")
var pre_player2 = preload("res://Game_Utils/Scenes/Player2.tscn")


onready var menu_pause = $menu_pause

var enemys_followers = []
var pre_enemy_follower = preload("res://Game_Utils/Scenes/Enemy1.tscn")

func _enter_tree():
	create_enemys_followers()


func _input(event):
	
	if GAME_MANAGER.win >= 3:
		##Ganhou o jogo
		pass
	
	if GAME_MANAGER.followers_enemys_die >= GAME_MANAGER.followers_enemys_count:
		GAME_MANAGER.phases_completed.pop_back()
		GAME_MANAGER.phases_completed.push_front(true)
		GAME_MANAGER.win += 1
		GAME_MANAGER.exp_division += GAME_MANAGER.win


	if Input.is_action_pressed("player1_pause"):
		
		if GAME_MANAGER.game_mode == "run":
			
			GAME_MANAGER.game_mode = "pause"
			get_tree().paused = true
			GAME_MANAGER.who_paused = "player1"
			menu_pause.show_and_load_variables(GAME_MANAGER.player1_Instance.test_boolean_for_skill_upped)
			
		
		elif GAME_MANAGER.game_mode == "pause" and GAME_MANAGER.who_paused == "player1":
			
			menu_pause.hide_menu()
			GAME_MANAGER.game_mode = "run"
			get_tree().paused = false
			GAME_MANAGER.who_paused = "nobody"
		
	elif Input.is_action_pressed("player2_pause") and GAME_MANAGER.gameplay_type == "multiplayer":
		
		if GAME_MANAGER.game_mode == "run":
			
			GAME_MANAGER.game_mode = "pause"
			get_tree().paused = true
			GAME_MANAGER.who_paused = "player2"
			menu_pause.show_and_load_variables(GAME_MANAGER.player2_Instance.test_boolean_for_skill_upped)
		
		elif GAME_MANAGER.game_mode == "pause" and GAME_MANAGER.who_paused == "player2":
			
			GAME_MANAGER.game_mode = "run"
			get_tree().paused = false
			GAME_MANAGER.who_paused = "nobody"
			menu_pause.hide_menu()
	


func _ready():
	
	
	if GAME_MANAGER.gameplay_type == "singleplayer":
		
		GAME_MANAGER.player1_Instance = pre_player1.instance()
		GAME_MANAGER.player1_Instance.global_position = $Position_Player1.global_position
		$players.add_child(GAME_MANAGER.player1_Instance)
	
	elif GAME_MANAGER.gameplay_type == "multiplayer":
		
		GAME_MANAGER.player1_Instance = pre_player1.instance()
		GAME_MANAGER.player1_Instance.global_position = $Position_Player1.global_position
		$players.add_child(GAME_MANAGER.player1_Instance)
		
		GAME_MANAGER.player2_Instance = pre_player2.instance()
		GAME_MANAGER.player2_Instance.global_position = $Position_Player2.global_position
		$players.add_child(GAME_MANAGER.player2_Instance)


func create_enemys_followers():
	# Criar os inimigos
	# Setar como filhos do nodo devido na cena main
	# Colocar ID neles
	# Setar a posição deles
	# Joga-los para um array no GameManager
	# Chamar o timer para eles começarem a aparecerem
		for i in range(0 , GAME_MANAGER.followers_enemys_count):
			var enemy_follower = pre_enemy_follower.instance()
			$Enemys_Followers.add_child(enemy_follower)
			enemy_follower.id = i
			enemy_follower.change_position()
			GAME_MANAGER.reference_of_enemys_followers.push_back(enemy_follower)
			enemy_follower.timer_to_start += i ## Talvez tenha que mudar o valor do tempo, pq pode ser q demore mt pros bicho ficar pronto
			enemys_followers.push_back(enemy_follower)


func _on_start_spawn_timer_timeout():
	GAME_MANAGER.start_game = true
