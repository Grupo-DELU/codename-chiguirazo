extends RigidBody2D

var projectile_speed = 400

func _ready() -> void:
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))