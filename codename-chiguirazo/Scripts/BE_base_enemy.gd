extends movemento_base

class_name base_Enemy

onready var steerings = preload("res://Scripts/S_steerings.gd").new()

var player  #Holds player node
var state = "Wander" #Estado actual pal' cerebro
var p_range = false  #Chequea si el jugadoor esta dentro del rango
var j_spotted = false #Esto para correr la animacion de panico

func _ready():
	update_stats()
	down = true
	randomize()

func Enem_take_damage(damage :float) ->void:   #Para ducktyping xd
	$"Health".Take_damage(damage)

func _process(delta):
	
	if !Move_check():   #Cambia de direccipon si vas a chocar
		#print("!")
		Change_diretion()
		
	match state:        #State Machine
		"Attack":
			steerings.Attacc(self)
			j_spotted = false
		"Wander":
			steerings.Wander()
		"Flee":
			steerings.Flee()
		

func Move_check():  #Revisa si vas a chocar
	
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
	p_range = true
	player = body
	state = "Attack"


func _on_PlayerDetector_body_exited(body: PhysicsBody2D) -> void:
	p_range = false
	state = "Wander"

func Get_player_pos():
	pass