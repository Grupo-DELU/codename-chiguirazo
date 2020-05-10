extends Movement_sys

class_name Base_Player

func get_input():
	#Cuando se tiene que mover esta wea
	if Input.is_action_pressed("ui_right"):
		move_right()
	if Input.is_action_just_released("ui_right"):
		right = false
	if Input.is_action_pressed("ui_left"):
		move_left()
	if Input.is_action_just_released("ui_left"):
		left = false
	if Input.is_action_pressed("ui_down"):
		move_down()
	if Input.is_action_just_released("ui_down"):
		down = false
	if Input.is_action_pressed("ui_up"):
		move_up()
	if Input.is_action_just_released("ui_up"):
		up = false
	

func _process(delta: float) -> void:
	#Detecta que te estoy pidiendo todo el tiempo
	get_input()