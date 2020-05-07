extends Attack_sys

class_name enem_attack

onready var Player = get_node("root/Main/Player")
#Atributos

#Métodos
func Attack_check():
	pass

func Aim(entity: Node2D):
	var target = entity.get_global_position()
	
	var direction = $Shoot_position.get_global_position().direction_to(target)
	
	return direction