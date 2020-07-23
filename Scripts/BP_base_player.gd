extends "res://Scripts/ME_base_interface.gd"

class_name player_interface

##Atributos para los sliders (estos se usan en nodos hijos)
export(float) var skill_cooldown :float= 2 #Tiemppo minimo entre usos de skills (Attack)

##Niveles
var level : int = 1
var xp_current :float = 0.0
var xp_required :float = 5.0

signal xp_add(body)
signal skill_used(body)

func _ready():
	update_stats()
	emit_signal("xp_add",self) 
	
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
		xp_required *= 1.5
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