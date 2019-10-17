extends Control

var scene_path_to_load
var scene_to_play = "res://Game_Utils/Scenes/main.tscn"
var scene_to_chose_player2 = "res://Game_Utils/Scenes/Menu_Scenes/Chose_ControllsPlayer2.tscn"

func _ready():
	
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	
	if !GAME_MANAGER.device_connected:
		
		for button in $Menu/CenterRow/Buttons.get_children():
			if button.player2_controll == "joystick":
				button.visible = false
		
	elif GAME_MANAGER.device_connected and GAME_MANAGER.number_of_device_connected != 2 and GAME_MANAGER.player1_Controll == "joystick":
		
		for button in $Menu/CenterRow/Buttons.get_children():
			if button.player2_controll == "joystick":
				button.visible = false
	
	$Menu/CenterRow/Buttons.get_child(0).grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed" , self , "_on_Button_pressed", [button.player2_controll])

func _on_Button_pressed(player2_controll):
	## Verificar se Possui Joystick conectado no computador, caso tenha sido esta a opção
	
	if player2_controll == "joystick":
		
		if GAME_MANAGER.number_of_device_connected != 2 and GAME_MANAGER.player1_Controll != "joystick":
			## Trocar o Device (Joystick) 1 para o Device (Joystick) 0  <<<<< Falta fazer isso
			## Nao sei como fazer
			print(InputMap.get_action_list("player2_up"))
			InputMap.get_action_list("player2_down")
			InputMap.get_action_list("player2_left")
			InputMap.get_action_list("player2_right")
			pass
	
	GAME_MANAGER.player2_Controll = player2_controll
	scene_path_to_load = scene_to_play
	print(GAME_MANAGER.player2_Controll)
	$FadeIn.show()
	$FadeIn.fade_in()
	



func _on_FadeIn_fade_finished():
	print(scene_path_to_load)
	get_tree().change_scene(scene_path_to_load)


func _on_joy_connection_changed(device_id, connected):
	
	if connected:
		GAME_MANAGER.device_connected = true
		print(Input.get_joy_name(device_id))
		GAME_MANAGER.number_of_device_connected += 1
	else:
		print("Keyboard")
		GAME_MANAGER.device_connected = false

