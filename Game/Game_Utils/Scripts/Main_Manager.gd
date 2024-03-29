extends Control

var pre_player1 = preload("res://Game_Utils/Scenes/Player1.tscn")
var pre_player2 = preload("res://Game_Utils/Scenes/Player2.tscn")


onready var menu_pause = $Navigation2D/menu_pause

var pre_enemy_follower = preload("res://Game_Utils/Scenes/Enemy1.tscn")
var pre_enemy_lerp = preload("res://Game_Utils/Scenes/Enemy2.tscn")

export var number_of_followers_enemys : int
export var number_of_lerp_enemys : int

func _enter_tree():
	pass


func _process(delta):
	if GAME_MANAGER.win >= 2:
		##Ganhou o jogo
		GAME_MANAGER.game_win = true
		print("GANHOUUUUUUUUUUUUUUUUU")
		pass
	
	if (GAME_MANAGER.followers_enemys_die + GAME_MANAGER.lerp_enemys_die) >= (GAME_MANAGER.followers_enemys_count + GAME_MANAGER.lerp_enemys_count) and (GAME_MANAGER.ready_to_wave and not GAME_MANAGER.game_win):
		GAME_MANAGER.ready_to_wave = false
		GAME_MANAGER.phases_completed.pop_back()
		GAME_MANAGER.phases_completed.push_front(true)
		GAME_MANAGER.win += 1
		GAME_MANAGER.exp_division += GAME_MANAGER.win
		GAME_MANAGER.all_enemys_stop = true
		print("MATEI TODOS OS INIMIGOS DA WAVE")
	
	if GAME_MANAGER.all_enemys_stop and not GAME_MANAGER.game_win:
		GAME_MANAGER.all_enemys_stop = false
		replay_in_enemys_followers()
		replay_in_enemys_lerp()
		GAME_MANAGER.ready_to_wave = true
		GAME_MANAGER.followers_enemys_die = 0
		GAME_MANAGER.lerp_enemys_die = 0
		print("VOU COMEÇAR A NOVA WAVE")


func _input(event):	
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
	## Setar o número de inimigos que existirão cena
	GAME_MANAGER.set_number_of_enemys_followers_in_game(number_of_followers_enemys) # Setando a variavel pelo inspetor
	GAME_MANAGER.set_number_of_enemys_lerp_in_game(number_of_lerp_enemys)
	#Cria os inimigos ( Apenas uma vez )
	create_enemys_followers()
	create_enemys_lerp()
	
	
	if GAME_MANAGER.gameplay_type == "singleplayer":
		
		GAME_MANAGER.player1_Instance = pre_player1.instance()
		GAME_MANAGER.player1_Instance.global_position = $Navigation2D/Position_Player1.global_position
		$Navigation2D/players.add_child(GAME_MANAGER.player1_Instance)
	
	elif GAME_MANAGER.gameplay_type == "multiplayer":
		
		GAME_MANAGER.player1_Instance = pre_player1.instance()
		GAME_MANAGER.player1_Instance.global_position = $Navigation2D/Position_Player1.global_position
		$Navigation2D/players.add_child(GAME_MANAGER.player1_Instance)
		
		GAME_MANAGER.player2_Instance = pre_player2.instance()
		GAME_MANAGER.player2_Instance.global_position = $Navigation2D/Position_Player2.global_position
		$Navigation2D/players.add_child(GAME_MANAGER.player2_Instance)

# Cria os inimigos
func create_enemys_followers():
	for i in range(0 , GAME_MANAGER.followers_enemys_count):
		var enemy_follower = pre_enemy_follower.instance()
		$Navigation2D/Enemys_Followers.add_child(enemy_follower)
		enemy_follower.id = i
		enemy_follower.change_position()
		GAME_MANAGER.reference_of_enemys_followers.push_back(enemy_follower)
		enemy_follower.timer_to_start += i ## Talvez tenha que mudar o valor do tempo, pq pode ser q demore mt pros bicho ficar pronto


func create_enemys_lerp():
	for i in range(0 , GAME_MANAGER.lerp_enemys_count):
		var enemy_lerp = pre_enemy_lerp.instance()
		$Navigation2D/Enemys_Lerp.add_child(enemy_lerp)
		enemy_lerp.id = i
		enemy_lerp.change_position()
		GAME_MANAGER.reference_of_enemys_lerp.push_back(enemy_lerp)
		enemy_lerp.timer_to_start += i ## Talvez tenha que mudar o valor do tempo, pq pode ser q demore mt pros bicho ficar pronto


# Função que é chamada para começar uma nova wave
func replay_in_enemys_followers():
	if not GAME_MANAGER.game_win:
		for i in GAME_MANAGER.reference_of_enemys_followers:
			i.change_position()
#			i.number_of_max_dies += 2 #
			i.timer_to_start
			i.im_active = true
	else:
		for i in GAME_MANAGER.reference_of_enemys_followers:
			i.change_position()
			i.im_active = false


func replay_in_enemys_lerp():
	if not GAME_MANAGER.game_win:
		for i in GAME_MANAGER.reference_of_enemys_lerp:
			i.change_position()
#			i.number_of_max_dies += 2 #
			i.timer_to_start
			i.im_active = true
	else:
		for i in GAME_MANAGER.reference_of_enemys_lerp:
			i.change_position()
			i.im_active = false

func _on_start_spawn_timer_timeout():
	GAME_MANAGER.start_game = true
