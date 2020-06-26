extends attaku_base

class_name pl_attack

#Atributos

var c_skill :bool = true  #Check de la capacidad para usar la skill del personaje
var skill_cooldown  :float
var prolongated_skill :bool = false
#Metodos

onready var Skill_timer = $"STimer"
onready var Player = get_parent()

func _physics_process(delta):
	if Input.is_action_just_pressed("attack") and c_attack:
		Basic_attack()
	if Input.is_action_just_pressed("skill") and c_skill:
		Use_skill()

func Basic_attack() -> void:
	Attack_timer.start()

func Use_skill() -> void:
	
	Skill_timer.start()
	

func _on_STimer_timeout():
	c_skill = true
	
