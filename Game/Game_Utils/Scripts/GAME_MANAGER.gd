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

var lerp_enemys_count : int
var followers_enemys_count : int
var followers_enemys_die  : int = 0
var lerp_enemys_die  : int = 0

var game_win = false

var win = 0
var exp_division = 2

var all_enemys_stop = false

var ready_to_wave = true

var phases_completed = [ false, false , false ]

var reference_of_enemys_followers = []
var reference_of_enemys_lerp = []

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


func stop_me_followers(id):
	for i in range(0, reference_of_enemys_followers.size()):
		if i == id:
			reference_of_enemys_followers[i].im_active = false


func stop_me_lerps(id):
	for i in range(0, reference_of_enemys_lerp.size()):
		if i == id:
			reference_of_enemys_lerp[i].im_active = false


func set_number_of_enemys_followers_in_game(number: int):
	followers_enemys_count = number


func set_number_of_enemys_lerp_in_game(number: int):
	lerp_enemys_count = number
