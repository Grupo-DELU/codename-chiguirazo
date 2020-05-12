extends Movement_sys

class_name Base_Player

func _ready():
	_update_stats()


func get_input():
	#Cuando se tiene que mover esta wea
	if Input.is_action_pressed("right"):
		move_right()
	if Input.is_action_just_released("right"):
		right = false
	if Input.is_action_pressed("left"):
		move_left()
	if Input.is_action_just_released("left"):
		left = false
	if Input.is_action_pressed("down"):
		move_down()
	if Input.is_action_just_released("down"):
		down = false
	if Input.is_action_pressed("up"):
		move_up()
	if Input.is_action_just_released("up"):
		up = false
	

func _process(delta: float) -> void:
	#Detecta que te estoy pidiendo todo el tiempo
	get_input()