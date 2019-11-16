extends KinematicBody2D

# Var's Move
var direction_x = 0
var direction_y = 0
var dir_rot_x = 0
var dir_rot_y = 0
var speed = 10000
var newDir

var level = 0 
var exp_bar = 0

var pre_bullet = preload("res://Game_Utils/Scenes/bullet_player2.tscn")

export var test_boolean_for_skill_upped = []


func _ready():
	test_array_for_menu()
	pass 

func _input(event):
	if GAME_MANAGER.game_mode == "pause":
		pass
	elif GAME_MANAGER.game_mode == "run":
		move_input_manager()


func _physics_process(delta):
	if GAME_MANAGER.game_mode == "pause":
		pass
	elif GAME_MANAGER.game_mode == "run":
		move_and_rotation(delta)
		shoot_manager()

func _process(delta):
	if GAME_MANAGER.game_mode == "pause":
		pass
	elif GAME_MANAGER.game_mode == "run":
		if exp_bar == 100:
			level += 1
			exp_bar = 0
			print("UPEI!!!!")
			print("My now level is: " + str(level))

### Manager Inputs
func move_input_manager():
	
	if Input.is_action_pressed("player2_right"):
		direction_x = 1
		dir_rot_x = 1
	elif Input.is_action_pressed("player2_left"):
		direction_x = -1
		dir_rot_x = -1
	else:
		direction_x = 0
		dir_rot_x = 0
	
	if Input.is_action_pressed("player2_up"):
		direction_y = -1
		dir_rot_y = 1
	elif Input.is_action_pressed("player2_down"): 
		direction_y = 1
		dir_rot_y = -1
	else:
		direction_y = 0
		dir_rot_y = 0

func shoot_manager():
	
	if Input.is_action_just_pressed("player2_shoot"):
		if get_tree().get_nodes_in_group("player2_bullets").size() < 3:
			var bullet = pre_bullet.instance()
			bullet.my_pattern = "player2"
			bullet.global_position = $muzzle.global_position
			bullet.dir = Vector2(sin(rotation) , -cos(rotation))
			get_parent().add_child(bullet)


### Functions of Movement and Rotation
func move_and_rotation(delta):
	newDir = -Vector2(dir_rot_x , dir_rot_y).normalized().angle()
	
	move_and_slide(Vector2(direction_x , direction_y) * speed * delta)
	
	var offset = PI / 2
	var rotation_to_mouse = newDir + offset
	global_rotation = lerp_angle(global_rotation, rotation_to_mouse, 0.25)

func lerp_angle(from, to, weight):
    return from + short_angle_dist(from, to) * weight

func short_angle_dist(from, to):
    var max_angle = PI * 2
    var difference = fmod(to - from, max_angle)
    return fmod(2 * difference, max_angle) - difference

func test_array_for_menu():
	for i in range(0 , 16):
		if i == 3 or i == 7 or i == 11 or i == 15:
			test_boolean_for_skill_upped.push_back(true)
		else:
			test_boolean_for_skill_upped.push_back(false)















