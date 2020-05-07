extends Attack_sys

class_name pl_attack

#Atributos

#Metodos
func Basic_attack():
	pass

func Use_skill():
	pass

func Mouse_aim():
	var start = $Shoot_position.get_global_position()
	var mouse_pos = get_global_mouse_position()
	
	var direction = start.direction_to(mouse_pos)
	
	return direction