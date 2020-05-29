extends Node2D

class_name Attack_sys

onready var main_scene = get_node("/root/Main")

#Atributos
var damage 
export(float) var atk_cooldown = 0.5
var can_attack = true

#Métodos:

func Attack(target: Vector2):
	pass

func Spawn_the(object):
	var thing = object.instance()
	
	thing.position = $Spawner.get_global_position()
	thing.z_index = -1
	thing.rotation = get_local_mouse_position().angle()
	
	return thing
	