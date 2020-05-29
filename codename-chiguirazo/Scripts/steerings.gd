extends Node

const TEMP_ANIMATION_TIME = 5

onready var attack_system = get_parent().get_node("Attaku System")


func attacc(target: Vector2, enemy):
	#esperarqueterminelaanimaciondealerta#
	#yield(get_tree().create_timer(TEMP_ANIMATION_TIME), "timeout")
	#sigue con la mirada al jugardor por varios segundos#
	#disparar#
	enemy.get_node("Attaku System").Attack(target)
	#repite el proceso#
	
func wander():
	pass
	
func flee():
	pass
	
	

