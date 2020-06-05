extends Node2D

class_name attaku_base

onready var m_scene :Node2D = get_node("/root/Main")

##Atributos##
var damage :float  #Daño que hacen los ataques
export(float) var a_cooldown :float= 0.5  #Tiempo minimo entre ataques
var c_attack :bool= true  #Check para saber si se puede atacar

##Métodos#


func Attack(target: Vector2):
	pass

func Spawn(object : PackedScene) -> Node2D:
	var thing :Node2D= object.instance()
	
	thing.position = $Spawner.get_global_position()
	thing.z_index = -1
	
	return thing
	