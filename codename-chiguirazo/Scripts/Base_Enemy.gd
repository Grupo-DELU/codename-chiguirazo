extends Movement_sys

class_name Base_Enemy

onready var steerings = preload("res://Scripts/steerings.gd").new()

var player
var state = "Wander"
var player_is_in_range = false
var just_spotted = false #Esto para correr la animacion de panico

func _ready():
	_update_stats()
	down = true
	randomize()

func Enem_take_damage(damage :float) ->void:   #Para ducktyping xd
	$"Healto System".Take_damage(damage)

func _process(delta):
	
	if !move_check():   #Cambia de direccipon si vas a chocar
		#print("!")
		change_direction()
		
	match state:        #State Machine
		"Attack":
			steerings.attacc(self)
			just_spotted = false
		"Wander":
			steerings.wander()
		"Flee":
			steerings.flee()
		

func move_check():  #Revisa si vas a chocar
	
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

func change_direction() -> void:   #Cambia dirección de forma random
	var dir_index = randi() % 4
	
	if up == true:    #Deja e moverse en la dirección actual
			up = false
	elif down == true:
			down = false
	elif left == true:
			left = false
	elif right == true:
			right = false
	
	match dir_index:   #Intenta moverse en otra dirección
		0:
			up = true
		1:
			down = true
		2:
			left = true
		3:
			right = true
			

func _on_PlayerDetector_body_entered(body: PhysicsBody2D) -> void:
	just_spotted = true
	player_is_in_range = true
	player = body
	state = "Attack"


func _on_PlayerDetector_body_exited(body: PhysicsBody2D) -> void:
	player_is_in_range = false
	state = "Wander"

func get_player_pos():
	pass