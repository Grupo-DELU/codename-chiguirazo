extends MarginContainer

onready var hp_bar : HBoxContainer= $"HBoxContainer/Bars/Health"
onready var exp_bar : HBoxContainer= $"HBoxContainer/Bars/Experience"

func _ready():
	var player : KinematicBody2D = get_node("/root/Main/Player")
	
	
	
	player.connect("xp_add",self,"Modify_xp")
	player.connect("health_updated",self, "Modify_health")
	Modify_health(player.Health.max_health)

func Modify_xp(player : KinematicBody2D):
	var counter : NinePatchRect = exp_bar.get_node("Counter/Background")
	var progress_bar: ProgressBar = exp_bar.get_node("ProgressBar")
	#update nivel actual
	counter.get_node("Number").text = str(player.level)
	##update barra de experiencia##
	progress_bar.max_value = player.xp_required
	progress_bar.value = max(0, player.xp_current)

func Modify_health(health):
	var counter : NinePatchRect = hp_bar.get_node("Counter/Background")
	var progress_bar: ProgressBar = hp_bar.get_node("ProgressBar")
	
	#update texto de vida
	counter.get_node("Number").text = str(max(0,health)) #que no dé un npumero menor que 0
								#               en todo caso si pasa esto es porque está muerto.
	
	#update healthbar#
	progress_bar.value = max(0,health)