extends Control

func _ready():
	$CenterContainer/VBoxContainer/Button.grab_focus()


func _on_Button_pressed():
	get_tree().change_scene("res://Game_Utils/Scenes/Menu_Scenes/TitleScreen.tscn")
