extends MarginContainer

onready var hp_bar : HBoxContainer= $"HBoxContainer/Bars/Health"
onready var exp_bar : HBoxContainer= $"HBoxContainer/Bars/Experience"
onready var skill_visual1 : ColorRect = $"HBoxContainer/Skills/ColorRect"
export(Color) var usable_skill_color = ColorN("darkblue")

func _ready():
	var player : KinematicBody2D = get_node("/root/Main/Player")
	
	player.connect("xp_add",self,"Modify_xp")
	player.connect("health_updated",self, "Modify_health")
	player.connect("skill_used",self,"Skill_feedback")
	
	Modify_health(player.Health.max_health) #Actualiza la GUI con la vida inicial de player

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
	var progress_bar: TextureProgress = hp_bar.get_node("ProgressBar")
	
	#update texto de vida
	counter.get_node("Number").text = str(max(0,health)) #que no dé un npumero menor que 0
								#               en todo caso si pasa esto es porque está muerto.
	
	#update healthbar#
	progress_bar.value = max(0,health)

func Skill_feedback(player : KinematicBody2D):
	var pAttack = player.Attack  #Nodo de ataque
	var cooldown_timer = pAttack.Skill_timer  #Señal cuando el cooldown acaba
	
	skill_visual1.color = ColorN("darkred") #Se usó la skill
	if pAttack.prolongated_skill: #casos particulares donde la skill no en insrantanea
		yield(pAttack,"b_finished")         #Se termino la skill 
		skill_visual1.color = ColorN("darkgray")
	yield(cooldown_timer,"timeout") #Se acaba el cooldown y el rectangulo vuelve a su color original
	skill_visual1.color = usable_skill_color
	