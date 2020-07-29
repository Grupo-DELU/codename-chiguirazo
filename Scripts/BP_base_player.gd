extends "res://Scripts/ME_base_interface.gd"

class_name player_interface

##Atributos para los sliders (estos se usan en nodos hijos)
export(float) var skill_cooldown :float= 2 #Tiemppo minimo entre usos de skills (Attack)

##Niveles
var level :int = 1
export(float) var operand_a :float = 2.5 #their use depends of the kind of level up (there are many for testing)
export(float) var operand_b :float = 2.5
var xp_current :float = 0.0
var xp_required :float

signal xp_add(body)
signal skill_used(body,id)

func _ready():
	update_stats()
	emit_signal("xp_add",self) 
	xp_required = operand_a + operand_b #Only exception to our exp required calculation function: 
			#                                 the exp required for the first level up
	
func update_stats():
	.update_stats()
	
	#Attack.get_node("STimer").wait_time = skill_cooldown
	Attack.Set_skill_cooldown("Skill1", skill_cooldown)
		  #hacer una sola función para los cooldowns de todas las skills???

func Player_take_damage(damage :float) ->void:   #Para ducktyping xd
	$"Health".Take_damage(damage)

#Metodos de experiencia y niveles

func add_xp(value: float) -> void:   #LLamada por un enemigo cuando muere (te da su xp)
	
	xp_current += value
	
	print("Player Current xp: " + str(xp_current))
	print("Player Required xp: " + str(xp_required))
	Level_up_call()
	

func Level_up_call() -> void:
	while xp_current >= xp_required:   #Cheque si tienes suficiente xp para subir de nivel(varias veces)
		xp_current -= xp_required
		
		xp_required = Quadratic_level_progression()
		
		Level_up()
	emit_signal("xp_add",self)

func Level_up() -> void:
	
	
	level += 1
	print("Nivel ", level, "!")
	   #Cada nivel requiere de mas xp para subir al siguiente
	
	Speed_change(max_speed + 25*level)             ##**EJEMPLO** de aumento de estadísticas (Lobito YUKA)
	Damage_change(damage + level)
	Defense_change(defense + level)
	Health.current_helth = Health.max_health
	emit_signal("health_updated",Health.current_helth)
	
	print("Player Current xp: " + str(xp_current))
	print("Player Required xp: " + str(xp_required))

##Test and choose one of the following##
func Quadratic_level_progression() -> float:
	
	var x :int = level + 1 #x stands for the actual level
	var y :float 
	#y stands for the exp required to reach next level
	#ax^2 + bx - y = 0 -> y = ax^2 + bx 
	y = operand_a*x*x + operand_b*x
	
	#hence x = (-b +- sqrt(b^2 + 4*a*y)) / 2a
	# determines how fast the progression goes, b moves the curve horizontally
	return y
	
	
