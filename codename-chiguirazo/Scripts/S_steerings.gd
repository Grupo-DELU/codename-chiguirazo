extends KinematicBody2D

const T_ANIMATION = 5  #Timepo que dura una animación...
const F_RADIUS = 200   #Radio de panico
const MAX_FORCE = 10  #Maxima fuerza del steering
const WANDER_RING_DISTANCE = 150   #Distancia del enemigo al centro del wandercircle
const WANDER_RING_RADIUS = 100  #Radio del WanderCircle
const FLEE_RADIUS = 1000 #Radio de panico

onready var a_system = get_parent().get_node("Attack")
onready var player = get_node("Main/Player")

var rng = RandomNumberGenerator.new()
var p_position : Vector2 #PlayerPosition
var steer: Vector2  #Steering Force
var d_velocity: Vector2  #Velocidad deseada para llegar al target
var s_time :float = 5.0  #Seeking_time
var t_start :bool = false #Start_the_timer
var t_seeking :bool = true #Its_seeking_time

func _process(delta: float) -> void:
	pass


func Attacc(enemy :Node2D) -> void:
	#esperarqueterminelaanimaciondealerta#
	if enemy.j_spotted == true:
		print("pAnIc")
	
	else:
		#Va a seguir con la mirada al player hasta que se acabe el cooldown
		p_position = enemy.player.get_global_position()
		if enemy.get_node("Attack").c_attack == false:
			#enemy.look_at(p_position)
			#print("te estoy siguiendo conchetumare")
			pass
		#Cuando se acabe dispara
		else:
			print("AJA!")
			enemy.get_node("Attack").Attack(p_position)

func Wander(enemy :Node2D) -> void:
	#Setea la posicion del WanderCircle
	enemy.max_speed = 50.0
	var future = enemy.global_position + (enemy.v_direction.normalized() * WANDER_RING_DISTANCE)
	#Agarra un valor random de la circunferencia del WanderCircle
	var target = future + Vector2(WANDER_RING_RADIUS,0).rotated(rng.randf_range(0,2 * PI))
	enemy.acc += seek(enemy,target) #Has que siga el target mediante seek
	
func Avoid(enemy:KinematicBody2D) -> Vector2:
	var closest_collider : PhysicsBody2D#Almacena el obstaculo mas cercano
	var colliding_whisker : RayCast2D = null #whisker que colisiona con el objeto que nos interesa
	var closest_coll_point: Vector2 = Vector2(999,999) #distancia del obstaculo mas cercano
	var pos : Vector2 = enemy.get_global_position() #posicion de este objeto
	
	#Temporales
	var collider : PhysicsBody2D #Obstaculo temporal
	var coll_point : Vector2 #punto de colision temporal
	
	# Fuerza requerida
	var steer_length
	var steer
	
	for w in enemy.whiskers.get_children():
		collider = w.get_collider()
		if collider:  #Truey si el whisker está chocando
			coll_point = w.get_collision_point()
			if pos.distance_to(coll_point) < pos.distance_to(closest_coll_point): #¿Debo priorizar la 
			                                                        #        colisión con este objeto?
				closest_collider = collider #de ser asi, lo guardo
				closest_coll_point = coll_point
				colliding_whisker = w
	
	if !colliding_whisker: #El choque se detuvo por si solo antes de llegar aqui
		return Vector2(0,0)
	
	steer_length = (colliding_whisker.get_cast_to() - closest_coll_point).length()
	steer = -colliding_whisker.get_collision_normal() * steer_length
	
	return -steer.clamped(MAX_FORCE)
	
	
	
func Flee(enemy: Node2D) ->void:
	steer = Vector2.ZERO
	var distance = (enemy.global_position - enemy.player.global_position).length()
	if distance < FLEE_RADIUS:
		enemy.player_in_panic_range = true
		enemy.max_speed = 300.0
		d_velocity = (enemy.global_position - enemy.player.global_position).normalized() * enemy.max_speed
	else:
		enemy.player_in_panic_range = false
		d_velocity = enemy.v_direction.normalized() * enemy.max_speed
	steer = d_velocity - enemy.v_direction
	steer = steer.clamped(MAX_FORCE)
	enemy.acc = steer

func seek(enemy, target):
	d_velocity = (target - enemy.global_position).normalized() * enemy.max_speed #maxima velocidad que se puede usar para llegar al objetivo
	steer = d_velocity - enemy.v_direction #se le resta la velocidad actual para obtener la velocidad restante
	steer = steer.clamped(MAX_FORCE) 
	return steer

