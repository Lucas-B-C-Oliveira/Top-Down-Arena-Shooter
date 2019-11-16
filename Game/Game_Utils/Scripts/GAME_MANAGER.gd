extends Node


var game_mode = ["run" , "pause"]
var player1_Controll = 0
var player2_Controll = 0
export(String, "multiplayer" , "singleplayer" ) var gameplay_type

var device_connected = false
var number_of_device_connected = 0

var player1_Instance
var player2_Instance

var start_game : bool = false

var followers_enemys_count : int = 20
var followers_enemys_die  : int = 0

var win = 0
var exp_division = 2

var phases_completed = [ false, false , false ]

export(String , "player1" , "player2", "nobody" ) var who_paused


func _ready():
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	game_mode = "run"
	print("Ready Do GameManager foi chamado")
	

func _on_joy_connection_changed(device_id, connected):
	
	if connected:
		device_connected = true
		print(Input.get_joy_name(device_id))
		number_of_device_connected += 1
	else:
		print("Não tem device conectado")
		device_connected = false


