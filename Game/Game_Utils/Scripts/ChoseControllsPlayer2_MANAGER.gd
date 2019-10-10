extends Control

var scene_path_to_load
var scene_to_play = "res://Game_Utils/Scenes/main.tscn"
var scene_to_chose_player2 = "res://Game_Utils/Scenes/Menu_Scenes/Chose_ControllsPlayer2.tscn"

func _ready():
	$Menu/CenterRow/Buttons.get_child(0).grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed" , self , "_on_Button_pressed", [button.player2_controll])

func _on_Button_pressed(player2_controll):
	## Verificar se Possui Joystick conectado no computador, caso tenha sido esta a opção
	GAME_MANAGER.player2_Controll = player2_controll
	scene_path_to_load = scene_to_play
	print(GAME_MANAGER.player2_Controll)
	$FadeIn.show()
	$FadeIn.fade_in()



func _on_FadeIn_fade_finished():
	print(scene_path_to_load)
	get_tree().change_scene(scene_path_to_load)
