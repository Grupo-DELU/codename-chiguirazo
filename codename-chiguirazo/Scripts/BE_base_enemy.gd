extends movemento_base2

class_name base_Enemy

onready var steerings = preload("res://Scripts/S_steerings.gd").new()
onready var whiskers = $"Whiskers"

var player : Node2D  #Holds player node
var player_in_range :bool = false  #Chequea si el jugadoor esta dentro del rango
var j_spotted : bool = false #Esto para correr la animacion de panico
var current_direction: int

enum States{
	Wander, Attack, Flee, Avoid
	} 
var state : int = States.Wander #Estado actual pal' cerebro

func _ready():
	update_stats()
	#right = true
	v_direction = Vector2.RIGHT
	randomize()

func Enem_take_damage(damage :float) ->void:   #Para ducktyping xd
	$"Health".Take_damage(damage)

func _process(delta):
	
	if !Move_check():   #Cambia de direccipon si vas a chocar
		state = States.Avoid
	elif state == States.Avoid:  #!!Posiblemente haya que hacer otras distinciones para
		state = States.Wander #   determinar si tiene que entrar en otro estado luego de esquivar.
		
	#if $"Health".current_helth < 2:
		#state = States.Flee
	Rotate_whiskers()
	
	match state:        #State Machine
		States.Attack:
			print("ORA")
			steerings.Attacc(self)
			j_spotted = false
			
		States.Wander:
			print("NaNa")
			if player_in_range:
				state = States.Attack
			steerings.Wander(self)
			
		States.Flee:
			steerings.Flee(self)
			
		States.Avoid:
			print("Ole")
			acc += steerings.Avoid(self)
		

func Move_check() -> bool:  #Revisa si vas a chocar
	
	for w in whiskers.get_children():
		if w.is_colliding():
			return false
	return true

func Change_diretion() -> void:   #Cambia dirección de forma random
	Rotate_whiskers()

func Rotate_whiskers() -> void:
	whiskers.rotation = v_direction.angle()

func _on_PlayerDetector_body_entered(body: PhysicsBody2D) -> void:
	j_spotted = true
	player_in_range = true
	player = body
	state = States.Attack


func _on_PlayerDetector_body_exited(body: PhysicsBody2D) -> void:
	if body == player:
		player_in_range = false
		state = States.Wander
		speed = 50

func Get_player_pos():
	pass


