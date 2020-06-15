extends movemento_base2

class_name base_Enemy

onready var steerings = preload("res://Scripts/S_steerings.gd").new()
onready var whiskers = $"Whiskers"

var player : Node2D  #Holds player node
var player_in_range :bool = false  #Chequea si el jugadoor esta dentro del rango
var j_spotted : bool = false #Esto para correr la animacion de panico
var current_direction: int

enum States{
	Wander, Attack , Flee
	} 
var state : int = States.Wander #Estado actual pal' cerebro

func _ready():
	update_stats()
	right = true
	randomize()

func Enem_take_damage(damage :float) ->void:   #Para ducktyping xd
	$"Health".Take_damage(damage)

func _process(delta):
	
	if !Move_check():   #Cambia de direccipon si vas a chocar

		Change_diretion()
		
	#if $"Health".current_helth < 2:
		#state = States.Flee
	
	match state:        #State Machine
		States.Attack:
			steerings.Attacc(self)
			j_spotted = false
		States.Wander:
			steerings.Wander(self)
		States.Flee:
			steerings.Flee(self)
		

func Move_check() -> bool:  #Revisa si vas a chocar
	
	for w in whiskers.get_children():
		if w.is_colliding():
			return false
	return true
	RayCast2D

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
			current_direction = 0
		1:
			down = true
			current_direction = 1
		2:
			left = true
			current_direction = 2
		3:
			right = true
			current_direction = 3
		
	Rotate_whiskers()
	

func Rotate_whiskers() -> void:
	var dir_vector = {up: Vector2.UP,down: Vector2.DOWN,left: Vector2.LEFT, right:Vector2.RIGHT}
	var actual_dir
	var c = 0
	
	for dir in [up,down,left,right]:
		if dir == true:
			actual_dir = dir_vector[dir]
			break
			
	whiskers.rotation = actual_dir.angle()



func _on_PlayerDetector_body_entered(body: PhysicsBody2D) -> void:
	j_spotted = true
	player_in_range = true
	player = body
	state = States.Attack


func _on_PlayerDetector_body_exited(body: PhysicsBody2D) -> void:
	player_in_range = false
	state = States.Wander
	speed = 50

func Get_player_pos():
	pass


