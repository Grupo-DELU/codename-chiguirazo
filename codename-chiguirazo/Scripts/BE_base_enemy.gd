extends movemento_base

class_name base_Enemy

onready var steerings = preload("res://Scripts/S_steerings.gd").new()

var player : Node2D  #Holds player node
var player_in_range :bool = false  #Chequea si el jugadoor esta dentro del rango
var j_spotted : bool = false #Esto para correr la animacion de panico

enum States{
	Wander, Attack , Flee
	} 
var state : int = States.Wander #Estado actual pal' cerebro

func _ready():
	update_stats()
	down = true
	randomize()

func Enem_take_damage(damage :float) ->void:   #Para ducktyping xd
	$"Health".Take_damage(damage)

func _process(delta):
	
	if !Move_check():   #Cambia de direccipon si vas a chocar
		print("!")
		Change_diretion()
		
	match state:        #State Machine
		States.Attack:
			steerings.Attacc(self)
			j_spotted = false
		States.Wander:
			steerings.Wander(self)
		States.Flee:
			steerings.Flee(self)
		

func Move_check():  #Revisa si vas a chocar
	
	if up == true:
		if get_node("RayCast2DUp").is_colliding():
			return
		else:
			return true
		
	elif down == true:
		if get_node("RayCast2DDown").is_colliding():
			print("ouch")
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

func Change_diretion() -> void:   #Cambia dirección de forma random
	var d_index = randi() % 4
	
	if up == true:    #Deja e moverse en la dirección actual
			up = false
	elif down == true:
			down = false
	elif left == true:
			left = false
	elif right == true:
			right = false
	
	match d_index:   #Intenta moverse en otra dirección
		0:
			up = true
		1:
			down = true
		2:
			left = true
		3:
			right = true
			

func _on_PlayerDetector_body_entered(body: PhysicsBody2D) -> void:
	j_spotted = true
	player_in_range = true
	player = body
	state = States.Attack


func _on_PlayerDetector_body_exited(body: PhysicsBody2D) -> void:
	player_in_range = false
	state = States.Wander

func Get_player_pos():
	pass


