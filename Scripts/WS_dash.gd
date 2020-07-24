extends "res://Scripts/BS_base_skill.gd"

export(float) var dash_duration :float = 1
export(float) var dash_distance :float = 100
var dash_speed :float
var direction :Vector2

var first_use: bool = true #Para inicializar ciertos nodos l primera vez que se usa la skill
var prev_mspd :float #Se cambiará la vlocidad máxima, esto es para recuperarla
var wolfie :Node2D #estos son los nodos
var wolf_mov :Node2D
var pre_dash :Vector2  #posición al empezar el dash


func _ready():
	set_physics_process(false) #We´ll be using physics process to make the dash when necessary

func Use_skill() -> void:
	#Player
	#can_use = false
	if first_use:
		wolfie = Manager.Player
		wolf_mov = wolfie.Movement
		first_use = false
	
	#distance and duration are set, calculate the speed
	dash_speed = dash_distance/dash_duration *10
	#dash direction
	direction = get_local_mouse_position()
	
	#backup
	pre_dash = get_global_position()
	prev_mspd = wolf_mov.max_speed
	
	#start the dash
	wolf_mov.max_speed = dash_speed #PLUS ULTRA
	set_physics_process(true)
	
	#cooldown part
	.Use_skill()
	

func _physics_process(delta):
	var dash_acl :float = dash_speed*1000 #acceleration that we use to reach the dash speed very quickly.
	var traveled_distance :Vector2
	
	wolf_mov.Apply_movement(direction*dash_acl)
	
	#Check the condition for the dash to end (has the dash covered enough distance?)
	traveled_distance = get_global_position() - pre_dash
	if traveled_distance.length() >= dash_distance:
		End_dash()

func End_dash() -> void:
	#Just goin back to normal(?)
	wolf_mov.max_speed = prev_mspd
	set_physics_process(false)

