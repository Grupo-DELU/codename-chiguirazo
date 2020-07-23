extends attaku_base

class_name pl_attack

#Atributos

onready var Player :KinematicBody2D = get_parent()
onready var Skill1 :Node2D = $"Skill1"
#Metodos
func _physics_process(delta):
	if Input.is_action_just_pressed("attack") and c_attack:
		Basic_attack()
	if Input.is_action_just_pressed("skill1") and Skill1.can_use:
		Skill1.Use_skill()
	#match (skill_input) ???

func Basic_attack() -> void:
	Attack_timer.start()

func Set_skill_cooldown(skill_name :String, time :float) -> void:
	var STimer
	for node in get_children():
		if node.name == skill_name:
			STimer = node.STimer
			break
	STimer.wait_time = time


