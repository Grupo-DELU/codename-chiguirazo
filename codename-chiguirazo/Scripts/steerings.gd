extends Node

const TEMP_ANIMATION_TIME = 5

onready var attack_system = get_parent().get_node("Attaku System")

func attacc():
	#esperarqueterminelaanimaciondealerta#
	#yield(get_tree().create_timer(TEMP_ANIMATION_TIME), "timeout")
	#disparar#
	attack_system.Attack()
	#apuntar durante 3.5s#
	#disparar#
	
func wander():
	pass
	
func flee():
	pass
	
