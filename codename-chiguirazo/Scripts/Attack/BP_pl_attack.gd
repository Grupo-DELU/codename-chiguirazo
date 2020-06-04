extends attaku_base

class_name pl_attack

#Atributos

var c_skill = true  #Check de la capacidad para usar la skill del personaje
export(float) var s_cooldown = 2 #Tiemppo minimo entre usos de skills
#Metodos


func _physics_process(delta):
	if Input.is_action_just_pressed("attack") and c_attack:
		Basic_attack()
	if Input.is_action_just_pressed("skill") and c_skill:
		Use_skill()

func Basic_attack() -> void:
	yield(get_tree().create_timer(c_attack),"timeout")
	c_attack = true

func Use_skill() -> void:
	yield(get_tree().create_timer(c_skill),"timeout")
	c_skill = true