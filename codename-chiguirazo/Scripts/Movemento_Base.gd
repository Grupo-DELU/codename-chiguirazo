extends KinematicBody2D

class_name Movement_sys

#Variables manejadas en nodos hijos 
export(float) var damage = 2 setget damage_change
export(float) var Defense = 1 setget defense_change

#Atributos de Movimiento
export(float) var speed = 300 
var dir =  Vector2()
var right = false
var left = false
var up = false
var down = false

#Setgets 

func damage_change(new_damage):
	damage = new_damage
	_update_stats()
	print("Daño: " + str(damage))

func defense_change(new_defense):
	Defense = new_defense
	_update_stats()
	print("Defensa: " + str(Defense))


#Métodos de Movimiento

func _update_stats():
	$"Attaku System".damage = damage
	$"Healto System".Defense = Defense
	
func move_left():
	left = true

func move_right():
	right = true
	
func move_up():
	up = true
	
func move_down():
	down = true

func _physics_process(delta: float) -> void:
	#Movimiento del Jugador
	dir = Vector2()
	if right:
		dir.x += 1
	if left:
		dir.x -= 1
	if down:
		dir.y += 1
	if up:
		dir.y -= 1
	if dir.length() > 0:
		dir = dir.normalized() * speed
		
	move_and_slide(dir)


