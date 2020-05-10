extends Movement_sys

class_name Base_Enemy

onready var Movement = get_node("Movemento System")

func _ready():
	down = true
	randomize()


func _process(delta):
	
	if !move_check(dir):
		print("!")
		change_direction()

func move_check(direction):
	
	if up == true:
		if get_node("RayCast2DUp").is_colliding():
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
	var dir_index = randi() % 4
	
	if up == true:
			up = false
	elif down == true:
			down = false
	elif left == true:
			left = false
	elif right == true:
			right = false
	
	match dir_index:
		0:
			up = true
		1:
			down = true
		2:
			left = true
		3:
			right = true