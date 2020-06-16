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
export(float) var speed :float = 300.0
var acc: Vector2 = Vector2.ZERO
var v_direction :Vector2=  Vector2()


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
	#v_direction = Vector2()
	
	v_direction += acc
	
	if v_direction.length() > 0:
		v_direction = v_direction.normalized() * speed
	move_and_slide(v_direction)


