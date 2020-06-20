extends KinematicBody2D

class_name movemento_base2

#Referencias a nodos hijos
onready var Attack = $"Attack"
onready var Health = $"Health"

#Variables manejadas en nodos hijos 
export(float) var damage :float = 2.0 setget Damage_change
export(float) var defense:float = 1.0 setget Defense_change
export(float) var attack_cooldown = 1

#Atributos de Movimiento
export(float) var max_speed :float = 500
var acc_magnitude = 2000
var acc: Vector2 = Vector2.ZERO
var v_direction :Vector2
var motion_direction: Vector2


#señales
signal health_updated(new_health) #Llamada desde Health


#Setgets 

func Damage_change(new_damage: float)-> void:
	damage = new_damage
	update_stats()
	print("Daño: " + str(damage))

func Defense_change(new_defense: float)-> void:
	defense = new_defense
	update_stats()
	print("Defensa: " + str(defense))

#Métodos de Movimiento

func update_stats()-> void:
	Attack.damage = damage
	Attack.get_node("ATimer").wait_time = attack_cooldown
	Health.defense = defense

func _physics_process(delta: float) -> void:
	#Movimiento del Jugador
	if Get_input() == null: #Diferenciar jugador y enemigo
		pass
	else:
		motion_direction = Get_input()
	if motion_direction == Vector2.ZERO:
		Apply_friction(acc_magnitude * delta)
	else:
		if acc == Vector2.ZERO: #Diferenciar jugador y enemigo
			Apply_movement(motion_direction * acc_magnitude * delta)
		else:
			Apply_movement(acc)
	move_and_slide(v_direction)

func Apply_friction(deceleration):
	if v_direction.length() > deceleration:
		v_direction -= v_direction.normalized() * deceleration
	else:
		v_direction = Vector2.ZERO
	
func Apply_movement(acceleration: Vector2):
	v_direction += acceleration
	v_direction = v_direction.clamped(max_speed)

func Get_input():
	pass