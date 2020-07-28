extends KinematicBody2D

class_name base_interface

#Referencias a nodos hijos
onready var Attack = $"Attack"
onready var Health = $"Health"
onready var Movement = $"Movement"

#Variables manejadas en nodos hijos 
export(float) var damage :float = 2.0 
export(float) var defense:float = 1.0 
export(float) var max_speed:float = 500 
export(float) var attack_cooldown = 1
export(float) var acceleration_time : float = 0.25 #Time taken to go from 0 to max

#señales
signal health_updated(new_health) #Llamada desde Health

#Setgets 

func _ready():
	Damage_change(damage)
	Defense_change(defense)
	Speed_change(max_speed)
	Acceleration_change(acceleration_time)

func Damage_change(new_damage: float)-> void:
	damage = new_damage
	update_stats()
	print("Daño: " + str(damage))

func Defense_change(new_defense: float)-> void:
	defense = new_defense
	update_stats()
	print("Defensa: " + str(defense))

func Speed_change(new_speed: float) -> void:
	max_speed = new_speed
	update_stats()
	if "Player" in name:
		print("Velocidad: " + str(max_speed))

func Acceleration_change(new_time):
	acceleration_time = new_time
	update_stats()
	
func update_stats()-> void:
	Attack.damage = damage
	Attack.get_node("ATimer").wait_time = attack_cooldown
	Health.defense = defense
	Movement.max_speed = max_speed
	Movement.acc_magnitude = max_speed / acceleration_time
