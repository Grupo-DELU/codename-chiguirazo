extends movemento_base

class_name enemy_movement

onready var whiskers = $"Whiskers"

func Move_check() -> bool:  #Revisa si vas a chocar
	
	for w in whiskers.get_children():
		if w.is_colliding():
			return false
	return true

func Rotate_whiskers() -> void:
	whiskers.rotation = v_direction.angle()