extends attaku_base

class_name pl_attack

#Atributos

onready var Player :KinematicBody2D = get_parent()

#onready var Skill1 :Node2D = $"Skill1"
var skill_count :int = 0
var Skill1 :Node2D = null
var Skill2 :Node2D = null
var Skill3 :Node2D = null
onready var skills :Dictionary ={
	"skill1" :Skill1, "skill2" :Skill2, "skill3" :Skill3}
#Metodos

func _ready():
	for i in get_children():
		if "Skill" in i.name:
			Register_skill(i)

func _physics_process(delta):
	if Input.is_action_just_pressed("attack") and c_attack:
		Basic_attack()
	#if Input.is_action_just_pressed("skill1") and skills["skill1"].can_use:
	#	Skill1.Use_skill()
	Check_for_skills()

func Basic_attack() -> void:
	Attack_timer.start()

func Set_skill_cooldown(skill_name :String, time :float) -> void:
	var STimer
	for node in get_children():
		if node.name == skill_name:
			STimer = node.STimer
			break
	STimer.wait_time = time

func Check_for_skills() -> void:
	for input in skills.keys():
		if Input.is_action_pressed(input):
			if skills[input] != null:
				print("skill exists")
				if skills[input].can_use:
					skills[input].Use_skill()

func Register_skill(skill :Node2D) -> void:
	skill_count +=1
	skill.name = "Skill"+str(skill_count)
	
	match skill_count:
		1: skills["skill1"] = $"Skill1"
		2: skills["skill2"] = $"Skill2"
		3: skills["skill3"] = $"Skill3"
	
