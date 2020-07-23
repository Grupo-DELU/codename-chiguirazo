extends movemento_base

class_name base_playeru_movement

#Movimiento
func Get_input() -> Vector2:
	#Cuando se tiene que mover esta wea
	var axis: Vector2 = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return axis.normalized()

	