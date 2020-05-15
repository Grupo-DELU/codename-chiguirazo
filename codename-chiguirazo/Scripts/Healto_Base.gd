extends Node2D

class_name Health_sys
#Atributos
export(float) var Max_Helth = 6
var current_helth = Max_Helth
var Defense

const DEATH_TIMER = 0.2

#Métodos

func _Die():
	#Desactivar hitbox
	get_parent().get_node("Hittoboxu").set_deferred("disabled",true)
	
	#Deje de moverse
	set_process(false)
	set_physics_process(false)
	
	#Sea expulsado al limbo de las bestias
	
	yield(get_tree().create_timer(DEATH_TIMER), "timeout")
	get_parent().queue_free()
	
func Take_damage(damage):
	
	var new_helth = current_helth - damage
	print("En: Daño inicial: " + str(damage))
	##Ajustes al daño
	
	if damage > 0: #Daño
		#Tomar en cuenta la defensa
		damage -= Defense
		if damage <= 0:
			damage = 0
	
	else:            #Curación
		if new_helth > Max_Helth:  #no curar por encima de la vida maxima
			damage = Max_Helth - current_helth
	
	##VFX##
	
	##ajuste de vida
	
	if damage == 0:
		return
	
	current_helth -= damage
	print("En: Vida: " + str(current_helth))
	if current_helth <= 0:
		_Die()