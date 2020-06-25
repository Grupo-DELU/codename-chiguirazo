extends Node2D

class_name movemento_base

var entity = get_parent()

#Atributos de Movimiento
export(float) var max_speed :float = 500
var acc_magnitude = max_speed / 0.25
var acc: Vector2 = Vector2.ZERO
var v_direction :Vector2
var motion_direction: Vector2

func _physics_process(delta: float) -> void:
	#Movimiento del Jugador
	if Get_input() != null: #Diferenciar jugador y enemigo
	
		motion_direction = Get_input()
	if motion_direction == Vector2.ZERO:
		Apply_friction(acc_magnitude * delta)
	else:
		if acc == Vector2.ZERO: #Diferenciar jugador y enemigo
			Apply_movement(motion_direction * acc_magnitude * delta)
		else:
			Apply_movement(acc)
	entity.move_and_slide(v_direction)

func Apply_friction(deceleration : float):
	if v_direction.length() > deceleration:
		v_direction -= v_direction.normalized() * deceleration
	else:
		v_direction = Vector2.ZERO
	
func Apply_movement(acceleration: Vector2):
	v_direction += acceleration
	v_direction = v_direction.clamped(max_speed)

func Get_input():
	pass