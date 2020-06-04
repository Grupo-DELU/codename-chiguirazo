extends KinematicBody2D

const T_ANIMATION = 5  #Timepo que dura una animación...

onready var a_system = get_parent().get_node("Attack")
var p_position 
var s_time = 5  #Seeking_time
var t_start = false #Start_the_timer
var t_seeking = true #Its_seeking_time

func _process(delta: float) -> void:
	pass


func Attacc(enemy):
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

func Wander():
	pass
	
func Flee():
	pass
	
	

