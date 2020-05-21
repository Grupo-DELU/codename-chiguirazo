extends Attack_sys

class_name pl_attack

#Atributos

var can_skill = true
export(float) var skl_cooldown = 2
#Metodos


func _physics_process(delta):
	if Input.is_action_just_pressed("attack") and can_attack:
		_Basic_attack()
	if Input.is_action_just_pressed("skill") and can_skill:
		_Use_skill()

func _Basic_attack() -> void:
	yield(get_tree().create_timer(atk_cooldown),"timeout")
	can_attack = true

func _Use_skill() -> void:
	yield(get_tree().create_timer(skl_cooldown),"timeout")
	can_skill = true