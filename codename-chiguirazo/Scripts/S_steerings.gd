extends KinematicBody2D

const T_ANIMATION = 5  #Timepo que dura una animación...

onready var a_system = get_parent().get_node("Attack")
var p_position : Vector2
var s_time :float = 5.0  #Seeking_time
var t_start :bool = false #Start_the_timer
var t_seeking :bool = true #Its_seeking_time

func _process(delta: float) -> void:
	pass


func Attacc(enemy :Node2D) -> void:
	#esperarqueterminelaanimaciondealerta#
	if enemy.j_spotted == true:
		print("pAnIc")
		pass
	else:
		#Sigue con la mirada al player hasta que se acabe el cooldown
		if enemy.get_node("Attack").c_attack == false:
			#p_position = enemy.player.get_global_position()
			#enemy.look_at(p_position)
			#print("te estoy siguiendo conchetumare")
			pass
		#Cuando se acabe dispara
		if enemy.get_node("Attack").c_attack == true:
			print("AJA!")
			p_position = enemy.player.get_global_position()
			enemy.get_node("Attack").Attack(p_position)

func Wander(enemy :Node2D) -> void:
	pass
	
func Flee(enemy :Node2D) ->void:
	pass
	
	

