extends base_interface

class_name base_enemy

onready var steerings = preload("res://Scripts/S_steerings.gd").new()
onready var ref_stats : Dictionary = {
	'speed' : max_speed, 'damage' : damage, 'defense' : defense
	}  #Este diccionario guarda las stats que tenia el enemigo al spawnear
	#El enemigo en algún momento volverá a tener estos stats, a diferencia del Player en caso de subir de nivel

var player : Node2D  #Holds player node
var player_in_attack_range :bool = false  #Chequea si el jugadoor esta dentro del rango de ataque
var player_in_panic_range: bool = true #Chequea si el jugadoor esta dentro del rango de panico

var j_spotted : bool = false #Esto para correr la animacion de panico
var panic_state: bool = false #Detecta si tiene poca vida


export(float) var exp_points = 69

enum States{
	Wander, Attack, Flee, Avoid
	} 
var state : int = States.Wander #Estado actual pal' cerebro

func _ready():
	update_stats()
	Health.experience = exp_points
	#right = true
	#motion_direction = Vector2.RIGHT
	randomize()

func Enem_take_damage(damage :float) ->void:   #Para ducktyping xd
	$"Health".Take_damage(damage)

func _process(delta):
	
	if !Movement.Move_check():   #Cambia de direccipon si vas a chocar
		state = States.Avoid
	elif state == States.Avoid:  #!!Posiblemente haya que hacer otras distinciones para
		state = States.Wander #   determinar si tiene que entrar en otro estado luego de esquivar.
		
	if $"Health".current_helth <= 2 and not panic_state:
		state = States.Flee
		panic_state = true         #para evitar que ataque
	if panic_state and player_in_panic_range:
		state = States.Flee        #para que siga huyendo cuando este en el rango
	if panic_state and not player_in_attack_range:
		state = States.Wander      #para que cambie a wander cuando salga del rango
	
	Movement.Rotate_whiskers()
	
	match state:        #State Machine
		States.Attack:
				
				steerings.Attacc(self)
				j_spotted = false
			
		States.Wander:
			
			if player_in_attack_range and not panic_state:
				if Attack.c_attack:
					state = States.Attack

			steerings.Wander(self)
			
		States.Flee:
			
			if not player_in_panic_range:
				state = States.Wander
			steerings.Flee(self)
		
		States.Avoid:
			
			Movement.acc += steerings.Avoid(self)
		

func _on_PlayerDetector_body_entered(body: PhysicsBody2D) -> void:
	j_spotted = true
	player_in_attack_range = true
	player = body


func _on_PlayerDetector_body_exited(body: PhysicsBody2D) -> void:
	if body == player:
		player_in_attack_range = false
		state = States.Wander
		#speed = 50

func Get_player_pos():
	pass


