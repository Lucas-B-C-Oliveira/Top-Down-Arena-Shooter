extends Node2D

var pre_player1 = preload("res://Game_Utils/Scenes/Player1.tscn")
var pre_player2 = preload("res://Game_Utils/Scenes/Player2.tscn")


func _input(event):
	
	if Input.is_action_pressed("player1_pause"):
		
		if GAME_MANAGER.game_mode == "run":
			
			GAME_MANAGER.game_mode = "pause"
			get_tree().paused = true
			GAME_MANAGER.who_paused = "player1"
		
		elif GAME_MANAGER.game_mode == "pause" and GAME_MANAGER.who_paused == "player1":
			
			GAME_MANAGER.game_mode = "run"
			get_tree().paused = false
			GAME_MANAGER.who_paused = "nobody"
		
	elif Input.is_action_pressed("player2_pause"):
		
		if GAME_MANAGER.game_mode == "run":
			
			GAME_MANAGER.game_mode = "pause"
			get_tree().paused = true
			GAME_MANAGER.who_paused = "player2"
		
		elif GAME_MANAGER.game_mode == "pause" and GAME_MANAGER.who_paused == "player2":
			
			GAME_MANAGER.game_mode = "run"
			get_tree().paused = false
			GAME_MANAGER.who_paused = "nobody"
	

func _ready():
	
	if GAME_MANAGER.gameplay_type == "singleplayer":
		
		GAME_MANAGER.player1_Instance = pre_player1.instance()
		GAME_MANAGER.player1_Instance.global_position = $Position_Player1.global_position
		$"../".add_child(GAME_MANAGER.player1_Instance)
	
	elif GAME_MANAGER.gameplay_type == "multiplayer":
		
		GAME_MANAGER.player1_Instance = pre_player1.instance()
		GAME_MANAGER.player1_Instance.global_position = $Position_Player1.global_position
		$"../".add_child(GAME_MANAGER.player1_Instance)
		
		GAME_MANAGER.player2_Instance = pre_player2.instance()
		GAME_MANAGER.player2_Instance.global_position = $Position_Player2.global_position
		$"../".add_child(GAME_MANAGER.player2_Instance)

