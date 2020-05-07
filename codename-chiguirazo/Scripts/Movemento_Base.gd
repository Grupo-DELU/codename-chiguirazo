extends KinematicBody2D

class_name Movement_sys
#Atributos
export(float) var speed = 300
var dir =  Vector2()
var right = false
var left = false
var up = false
var down = false

#Métodos
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
	