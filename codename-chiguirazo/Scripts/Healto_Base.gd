extends Node2D

class_name Health_sys
#Atributos
export(float) var Max_Helth = 6
var current_helth = Max_Helth
var Defense

const DEATH_TIMER = 0.2

#Métodos

func _Die()-> void:
	#Desactivar hitbox
	get_parent().get_node("Hittoboxu").set_deferred("disabled",true)
	
	#Deje de moverse
	set_process(false)
	set_physics_process(false)
	
	#Sea expulsado al limbo de las bestias
	
	yield(get_tree().create_timer(DEATH_TIMER), "timeout")
	get_parent().queue_free()
	
func Take_damage(damage: float) -> void:
	
	var new_helth = current_helth - damage
	print("Daño inicial recibido: " + str(damage))
	##Ajustes al daño
	
	if damage > 0: #Daño
		#Tomar en cuenta la defensa
		damage -= Defense
		#Daño no puede pasar a negativo de este modo
		damage = max(0, damage)
	
	else:            #Curación
		if new_helth > Max_Helth:  #no curar por encima de la vida maxima
			damage = - (Max_Helth - current_helth)
		
		# La curación no debe sr suficiene para pasarse de Max_Helth
		damage = - (min(Max_Helth,new_helth) - current_helth)
		             #El daño será suficiente para llegar a uno de estos 2 parámetros
					#Se le resta current_health para que esté en base a 0, y se le cambia el signo para que pase a ser una curación
	##VFX##
	
	##ajuste de vida
	
	if damage == 0:
		return
	
	current_helth -= damage
	if current_helth > 0:
		print("Vida luego de recibir el ataque: " + str(current_helth))
	if current_helth <= 0:
		current_helth = 0
		print("Vida luego de recibir el ataque: " + str(current_helth))
		_Die()