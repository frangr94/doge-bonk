extends CharacterBody2D

var SPEED = 400

var vel:float

func _physics_process(delta: float) -> void:
	move_local_x(vel * SPEED * delta)
	pass
