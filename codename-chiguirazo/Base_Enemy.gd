extends Movement_sys

class_name Base_Enemy

func _ready():
	down = true
	randomize()


func _process(delta):
	
	if !move_check(dir):    #Cambio de dirección si la entidad va a colisionar
		change_direction()

func move_check(direction):
	#Usa cada Raycast para verificar si es posible moverse en su dirección
	if up == true:
		if get_node("RayCast2DUp").is_colliding(): #Si el Raycast está colisionando, el movimiento no es posible
			return
		else:
			return true
		
	elif down == true:
		if get_node("RayCast2DDown").is_colliding():
			return
		else:
			return true
		
	elif left == true:
		if get_node("RayCast2DLeft").is_colliding():
			return
		else:
			return true
		
	elif right == true:
		if get_node("RayCast2DRight").is_colliding():
			return
		else:
			return true

func change_direction():
	var dir_index = randi() % 4 #PAra elegir otra dirección
	
	if up == true:       #Cancela el movimiento en una dirección
			up = false
	elif down == true:
			down = false
	elif left == true:
			left = false
	elif right == true:
			right = false
	
	match dir_index:     #Y empieza a moverte en otra dirección al azar.
		0:
			up = true
		1:
			down = true
		2:
			left = true
		3:
			right = true