extends Node


var game_mode = ["run" , "pause"]
var player1_Controll = 0
var player2_Controll = 0
export(String, "multiplayer" , "singleplayer" ) var gameplay_type


func _ready():
	game_mode = "run"
	


