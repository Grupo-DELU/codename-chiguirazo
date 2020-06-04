extends KinematicBody2D

class_name movemento_base

#Variables manejadas en nodos hijos 
export(float) var damage = 2 setget Damage_change
export(float) var defense = 1 setget Defense_change

#Atributos de Movimiento
export(float) var speed = 300 
var dir =  Vector2()
var right = false
var left = false
var up = false
var down = false

#Setgets 

func Damage_change(new_damage: float)-> void:
	damage = new_damage
	update_stats()
	print("Daño: " + str(damage))

func Defense_change(new_defense: float)-> void:
	defense = new_defense
	update_stats()
	print("Defensa: " + str(defense))


#Métodos de Movimiento

func update_stats()-> void:
	$"Attack".damage = damage
	$"Health".defense = defense
	
func move_left()-> void:
	left = true

func move_right()-> void:
	right = true
	
func move_up()-> void:
	up = true
	
func move_down()-> void:
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


