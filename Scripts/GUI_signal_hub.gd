extends MarginContainer

#A lot of GUI children
onready var hp_bar : HBoxContainer= $"HBoxContainer/Bars/Health"
onready var hp_counter : NinePatchRect = hp_bar.get_node("Counter/Background")
onready var hp_progress_bar: TextureProgress = hp_bar.get_node("ProgressBar")

onready var exp_bar : HBoxContainer= $"HBoxContainer/Bars/Experience"
onready var xp_counter : NinePatchRect = exp_bar.get_node("Counter/Background")
onready var xp_progress_bar: TextureProgress = exp_bar.get_node("ProgressBar")

onready var skill_visual1 : ColorRect = $"HBoxContainer/Skills/ColorRect"


#A lot of colors to see
export(Color) var skill_usable = ColorN("darkblue")
export(Color) var skill_in_use = ColorN("darkred")
export(Color) var skill_in_cooldown = ColorN("darkgray")

func _ready() ->void:
	var player : KinematicBody2D = get_node("/root/Main/Player")
	
	player.connect("xp_add",self,"Modify_xp")
	player.connect("health_updated",self, "Modify_health")
	player.connect("skill_used",self,"Skill_feedback")
	
	Modify_health(player.Health.max_health) #Actualiza la GUI con la vida inicial de player

func Modify_xp(player : KinematicBody2D) ->void:
	#update nivel actual
	xp_counter.get_node("Number").text = str(player.level)
	##update barra de experiencia##
	xp_progress_bar.max_value = player.xp_required
	xp_progress_bar.value = max(0, player.xp_current)

func Modify_health(health :float) ->void:
	#update texto de vida
	hp_counter.get_node("Number").text = str(max(0,health)) #que no dé un npumero menor que 0
								#               en todo caso si pasa esto es porque está muerto.
	#update healthbar#
	hp_progress_bar.value = max(0,health)

func Skill_feedback(player : KinematicBody2D) ->void:
	var pAttack :Node = player.Attack  #Nodo de ataque
	var skill : Node = pAttack.get_node("Skill1") #Cada skill tendrá su icono en laGUI
	#Cada skill deberia emitir su propia señal ???
	var cooldown_timer : Node = skill.get_node("SkillTimer")  #Señal cuando el cooldown acaba
	
	skill_visual1.color = skill_in_use #Se usó la skill
	if skill.is_prolongated: #casos particulares donde la skill no en insrantanea
		yield(skill,"b_finished")         #Se termino la skill 
		skill_visual1.color = skill_in_cooldown
	yield(cooldown_timer,"timeout") #Se acaba el cooldown y el rectangulo vuelve a su color original
	skill_visual1.color = skill_usable
	
