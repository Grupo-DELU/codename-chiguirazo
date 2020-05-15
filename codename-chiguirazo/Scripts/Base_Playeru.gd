extends Movement_sys

class_name Base_Player

#Atributos de xperiencia y niveles
var level = 1
var current_xp = 0
var required_xp = 5

func _ready():
	_update_stats()

#Movimiento
func get_input():
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

func add_xp(value):   #LLamada por un enemigo cuando muere (te da su xp)
	
	current_xp += value
	
	print(current_xp)
	print(required_xp)
	
	while current_xp >= required_xp:   #Cheque si tienes suficiente xp para subir de nivel(varias veces)
		
		print("Eh subio de nivel :0")
		current_xp -= required_xp
		required_xp *= 1.5
		_Level_up()

func _Level_up():
	
	
	level += 1
	print("Nivel ", level, "!")
	   #Cada nivel requiere de mas xp para subir al siguiente
	
	speed += 25*level             ##**EJEMPLO** de aumento de estadísticas (Lobito YUKA)
	damage_change(damage + level)
	defense_change(Defense + level)
	
	print("Oshi")
	print(current_xp)
	print(required_xp)

