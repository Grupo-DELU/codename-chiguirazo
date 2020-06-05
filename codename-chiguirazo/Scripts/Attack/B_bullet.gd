extends RigidBody2D

var p_speed :float = 400.0  #Velocidad del proyetil
var damage : float			#Daño del proyectil


func _ready() -> void:
	apply_impulse(Vector2(), Vector2(p_speed, 0).rotated(rotation))
	yield(get_tree().create_timer(5),"timeout")
	queue_free()

