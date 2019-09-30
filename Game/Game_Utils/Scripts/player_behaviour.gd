extends KinematicBody2D

# Var's Move
var direction_x = 0
var direction_y = 0
var dir_rot_x = 0
var dir_rot_y = 0
var speed = 10000
var newDir


func _ready():
	pass 

func _input(event):
	move_input_manager()


func _physics_process(delta):
	move(delta)

func _process(delta):
	pass

### Manager Inputs
func move_input_manager():
	
	if Input.is_action_pressed("ui_right"):
		direction_x = 1
		dir_rot_x = 1
	elif Input.is_action_pressed("ui_left"):
		direction_x = -1
		dir_rot_x = -1
	else:
		direction_x = 0
		dir_rot_x = 0
	
	if Input.is_action_pressed("ui_up"):
		direction_y = -1
		dir_rot_y = 1
	elif Input.is_action_pressed("ui_down"): 
		direction_y = 1
		dir_rot_y = -1
	else:
		direction_y = 0
		dir_rot_y = 0



### Function of Movement
func move(delta):
	newDir = Vector2(dir_rot_y , dir_rot_x).normalized().angle()
	
	if global_rotation != newDir:
		global_rotation = lerp(global_rotation, newDir, .3)
	
	move_and_slide(Vector2(direction_x , direction_y) * speed * delta)


















