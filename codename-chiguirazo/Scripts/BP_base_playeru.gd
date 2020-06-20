extends movemento_base2

class_name base_playeru

##Atributos para los sliders (estos se usan en nodos hijos)
export(float) var skill_cooldown :float= 2 #Tiemppo minimo entre usos de skills (Attack)

#Atributos de xperiencia y niveles
var level : int = 1
var xp_current :float = 0.0
var xp_required :float = 5.0

func _ready():
	update_stats()

func update_stats():
	.update_stats()
	Attack.get_node("STimer").wait_time = skill_cooldown

#Movimiento
func Get_input() -> Vector2:
	#Cuando se tiene que mover esta wea
	var axis: Vector2 = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return axis.normalized()
	
func _process(delta: float) -> void:
	#Detecta que te estoy pidiendo todo el tiempo
	#get_input()
	pass
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

func Level_up() -> void:
	
	
	level += 1
	print("Nivel ", level, "!")
	   #Cada nivel requiere de mas xp para subir al siguiente
	
	max_speed += 25*level             ##**EJEMPLO** de aumento de estadísticas (Lobito YUKA)
	Damage_change(damage + level)
	Defense_change(defense + level)
	
	print("Player Current xp: " + str(xp_current))
	print("Player Required xp: " + str(xp_required))

func Player_take_damage(damage :float) ->void:   #Para ducktyping xd
	$"Health".Take_damage(damage)