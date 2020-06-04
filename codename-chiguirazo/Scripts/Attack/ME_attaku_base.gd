extends Node2D

class_name attaku_base

onready var m_scene = get_node("/root/Main")

##Atributos##
var damage  #Daño que hacen los ataques
export(float) var a_cooldown = 0.5  #Tiempo minimo entre ataques
var c_attack = true  #Check para saber si se puede atacar

##Métodos#


func Attack(target: Vector2):
	pass

func Spawn(object):
	var thing = object.instance()
	
	thing.position = $Spawner.get_global_position()
	thing.z_index = -1
	
	return thing
	