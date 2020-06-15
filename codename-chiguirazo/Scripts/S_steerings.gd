extends KinematicBody2D

const T_ANIMATION = 5  #Timepo que dura una animación...
const F_RADIUS = 200   #Radio de panico
const MAX_FORCE = 10  #Maxima fuerza del steering
const WANDER_RING_DISTANCE = 150   #Distancia del enemigo al centro del wandercircle
const WANDER_RING_RADIUS = 100  #Radio del WanderCircle

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
		pass
	else:
		#Sigue con la mirada al player hasta que se acabe el cooldown
		if enemy.get_node("Attack").c_attack == false:
			#p_position = enemy.player.get_global_position()
			#enemy.look_at(p_position)
			#print("te estoy siguiendo conchetumare")
			pass
		#Cuando se acabe dispara
		if enemy.get_node("Attack").c_attack == true:
			print("AJA!")
			p_position = enemy.player.get_global_position()
			enemy.get_node("Attack").Attack(p_position)

func Wander(enemy :Node2D) -> void:
	#Setea la posicion del WanderCircle
	var future = enemy.global_position + (enemy.v_direction.normalized() * WANDER_RING_DISTANCE)
	#Agarra un valor random de la circunferencia del WanderCircle
	var target = future + Vector2(WANDER_RING_RADIUS,0).rotated(rng.randf_range(0,2 * PI))
	enemy.acc = seek(enemy,target) #Has que siga el target mediante seek
	if !enemy.Move_check():
		match enemy.current_direction: #Si chocas cambia la velocidad en la direccion contraria al choque
			0:
				enemy.v_direction = Vector2(0,-enemy.speed)
			1:
				enemy.v_direction = Vector2(0,enemy.speed)
			2:
				enemy.v_direction = Vector2(-enemy.speed,0)
			3:
				enemy.v_direction = Vector2(enemy.speed,0)
	
	
	
func Flee(enemy :Node2D) ->void:
	pass
	
func seek(enemy, target):
	d_velocity = (target - enemy.global_position).normalized() * enemy.speed
	steer = d_velocity - enemy.v_direction
	steer = steer.clamped(MAX_FORCE)
	return steer

