extends Control

var life
var mana
var speed

onready var parent_skill1 = $"SKILL_1"
onready var parent_skill2 = $"SKILL_2"
onready var parent_skill3 = $"SKILL_3"
onready var parent_skill4 = $"SKILL_4"

var skills = []
var skill_upada = []
onready var parent_skills = [parent_skill1 , parent_skill2 , parent_skill3 , parent_skill4]

export var test_boolean_for_skill_upped = []


func _ready():
	
	parent_skill1.get_child_count()
	print(parent_skill1.get_children())
	
	for item in parent_skills:
#		skills.push_back(item.get_children())
		for button in item.get_children():
			skills.push_back(button)
		print(skills)
	
	for i in range(0 , skills.size()):
		if i == 3 or i == 7 or i == 11 or i == 15:
			test_boolean_for_skill_upped.push_back(true)
		else:
			test_boolean_for_skill_upped.push_back(false)
	
	
	visible = false
#	show_and_load_variables(test_boolean_for_skill_upped)


func show_and_load_variables(skill_upped):
	self.visible = true
	
	for i in range(0 , skill_upped.size()):
		
		if skill_upped[i]:
			skills[i].disabled = true

func hide_menu():
	self.visible = false
