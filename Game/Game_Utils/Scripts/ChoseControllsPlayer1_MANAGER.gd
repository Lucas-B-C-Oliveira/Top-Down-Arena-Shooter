extends Control

var scene_path_to_load
var scene_to_play = "res://Game_Utils/Scenes/main.tscn"
var scene_to_chose_player2 = "res://Game_Utils/Scenes/Menu_Scenes/Chose_ControllsPlayer2.tscn"

func _ready():
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	
	if !GAME_MANAGER.device_connected:
		for button in $Menu/CenterRow/Buttons.get_children():
			if button.player1_controll == "joystick":
				button.visible = false
	
	print(GAME_MANAGER.gameplay_type)
	if GAME_MANAGER.gameplay_type == "multiplayer":
		scene_path_to_load = scene_to_chose_player2;
	elif GAME_MANAGER.gameplay_type == "singleplayer":
		scene_path_to_load = scene_to_play;
	## Verificar se Possui Joystick conectado no computador, caso tenha sido esta a opção
	$Menu/CenterRow/Buttons.get_child(0).grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed" , self , "_on_Button_pressed", [button.player1_controll])

func _on_Button_pressed(player1_controll):
	GAME_MANAGER.player1_Controll = player1_controll
	print(GAME_MANAGER.player1_Controll)
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
