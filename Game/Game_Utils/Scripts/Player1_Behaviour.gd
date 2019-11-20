extends KinematicBody2D

# Var's Move
var direction_x = 0
var direction_y = 0
var dir_rot_x = 0
var dir_rot_y = 0
var speed = 10000
var newDir

var old_level : int = 0
var level = 0 
var exp_bar = 0

var life = 3

var speed_bullet = 0

var bullet_size = Vector2.ZERO

var update : bool = false

var pre_bullet = preload("res://Game_Utils/Scenes/bullet_player1.tscn")

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
		
		update_level()
		
		if exp_bar == 100:
			old_level = level
			exp_bar = 0
			update = true
			level += 1
			print("UPEI!!!!")
			print("My now level is: " + str(level))


func update_level():
	if Input.is_action_just_pressed("player1_update_life") and update: # 1
		if old_level == level - 1:
			print("Upei minha vida")
			print("Old_Life: " + str(life))
			life += 1
		elif old_level == level - 2:
			life += 2
		elif old_level == level - 3:
			life += 3
		print("new life: " + str(life))
		update = false
	elif Input.is_action_just_pressed("player1_update_bullet_speed") and update: # 2
		if old_level == level - 1:
			print("Upei minha bullet speed")
			print("old bullet speed: " + str(speed_bullet))
			speed_bullet += 100
		elif old_level == level - 2:
			speed_bullet += 200
		elif old_level == level - 3:
			speed_bullet += 300
		update = false
	elif Input.is_action_just_pressed("player1_update_bullet_size") and update: # 3
		if old_level == level - 1:
			print("UPEI O SIZE DA BULLET")
			bullet_size += Vector2(0.1, 0.1)
		elif old_level == level - 2:
			bullet_size += Vector2(0.2, 0.2)
		elif old_level == level - 3:
			bullet_size += Vector2(0.3, 0.3)
		update = false
	elif Input.is_action_just_pressed("player1_update_speed") and update: # 4
		if old_level == level - 1:
			speed += 1000
		elif old_level == level - 2:
			speed += 2000
		elif old_level == level - 3:
			speed += 3000 
		update = false


### Manager Inputs
func move_input_manager():
	
	if Input.is_action_pressed("player1_right"):
		direction_x = 1
		dir_rot_x = 1
	elif Input.is_action_pressed("player1_left"):
		direction_x = -1
		dir_rot_x = -1
	else:
		direction_x = 0
		dir_rot_x = 0
	
	if Input.is_action_pressed("player1_up"):
		direction_y = -1
		dir_rot_y = 1
	elif Input.is_action_pressed("player1_down"): 
		direction_y = 1
		dir_rot_y = -1
	else:
		direction_y = 0
		dir_rot_y = 0


func shoot_manager():
	
	if Input.is_action_just_pressed("player1_shoot"):
#		if get_tree().get_nodes_in_group("player1_bullets").size() < 3: # descomentar para colocar limites nas balas #TEST
		var bullet = pre_bullet.instance()
		bullet.my_pattern = "player1"
		bullet.speed += speed_bullet
		bullet.set_size(bullet_size)
		bullet.global_position = $muzzle.global_position
		var target_direction = Vector2(cos(rotation) , sin(rotation))
		bullet.dir = target_direction
		bullet.set_new_rotation(global_rotation)
		get_parent().add_child(bullet)


### Functions of Movement and Rotation
func move_and_rotation(delta):
	
	move_and_slide(Vector2(direction_x , direction_y) * speed * delta)
	look_at(get_global_mouse_position())
	
#	newDir = -Vector2(dir_rot_x , dir_rot_y).normalized().angle()
#	var offset = PI / 2
#	var rotation_to_mouse = newDir + offset
#	global_rotation = lerp_angle(global_rotation, rotation_to_mouse, 0.25)


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














