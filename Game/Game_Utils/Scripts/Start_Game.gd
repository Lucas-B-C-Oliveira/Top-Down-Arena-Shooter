extends Button

export(String, "joystick", "keyboard") var player1_controll
export(String, "joystick", "keyboard") var player2_controll

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_parent().get_children():
		if button is CheckButton:
#			print(button)
			pass
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
