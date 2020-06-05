extends movemento_base

class_name base_playeru

#Atributos de xperiencia y niveles
var level : int = 1
var xp_current :float = 0.0
var xp_required :float = 5.0

func _ready():
	update_stats()

#Movimiento
func get_input() -> void:
	#Cuando se tiene que mover esta wea
	if Input.is_action_pressed("right"):
		move_right()
	if Input.is_action_just_released("right"):
		right = false
	if Input.is_action_pressed("left"):
		move_left()
	if Input.is_action_just_released("left"):
		left = false
	if Input.is_action_pressed("down"):
		move_down()
	if Input.is_action_just_released("down"):
		down = false
	if Input.is_action_pressed("up"):
		move_up()
	if Input.is_action_just_released("up"):
		up = false
	
func _process(delta: float) -> void:
	#Detecta que te estoy pidiendo todo el tiempo
	get_input()

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
	
	speed += 25*level             ##**EJEMPLO** de aumento de estadísticas (Lobito YUKA)
	Damage_change(damage + level)
	Defense_change(defense + level)
	
	print("Player Current xp: " + str(xp_current))
	print("Player Required xp: " + str(xp_required))

