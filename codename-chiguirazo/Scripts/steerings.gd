extends KinematicBody2D

const TEMP_ANIMATION_TIME = 5

onready var attack_system = get_parent().get_node("Attaku System")
var player_position 
var seeking_time = 5
var start_the_timer = false
var its_seeking_time = true

func _process(delta: float) -> void:
	pass


func attacc(enemy):
	#esperarqueterminelaanimaciondealerta#
	if enemy.just_spotted == true:
		print("pAnIc")
		pass
	else:
		#Sigue con la mirada al player hasta que se acabe el cooldown
		if enemy.get_node("Attaku System").can_attack == false:
			#player_position = enemy.player.get_global_position()
			#enemy.look_at(player_position)
			print("te estoy siguiendo conchetumare")
		#Cuando se acabe dispara
		if enemy.get_node("Attaku System").can_attack == true:
			print("AJA!")
			player_position = enemy.player.get_global_position()
			enemy.get_node("Attaku System").Attack(player_position)

func wander():
	pass
	
func flee():
	pass
	
	

