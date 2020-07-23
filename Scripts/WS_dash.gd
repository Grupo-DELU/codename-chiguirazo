extends "res://Scripts/BS_base_skill.gd"

var dash_duration :float = 0.1
var dash_distance :float = 10
var dash_speed :float
var direction :Vector2

var first_use: bool = true
var prev_acc :float
var wolfie :Node2D
var wolf_mov :Node2D
var pre_dash :Vector2


func _ready():
	set_physics_process(false)
	$DashTime.wait_time = dash_duration
	cooldown += dash_duration

func Use_skill() -> void:
	#Player
	#can_use = false
	if first_use:
		wolfie = Manager.Player
		wolf_mov = wolfie.Movement
		first_use = false
	
	#Dadas la duración y la distancia, calcula la velocidad
	dash_speed = dash_distance/dash_duration
	#dirección del dash
	direction = get_local_mouse_position()
	pre_dash = get_global_position()
	#Hacer el dash
	set_physics_process(true)
	
	$DashTime.start()
	.Use_skill()
	

func _physics_process(delta):
	wolf_mov.Apply_movement(direction*((2*dash_speed)/dash_duration)*delta)

func _on_DashTime_timeout():
	
	set_physics_process(false)
"""
func Test_distance() -> bool:
	if pre_dash.distance_to(get_global_position()) >= dash_distance:
		return true
	else:	return false
"""""
