extends Area2D

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var animatable_body_2d: AnimatableBody2D = $".."

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D



func _on_body_entered(body: Node2D) -> void:
	print("activate platform")
	if animatable_body_2d.position.y <= -234:
		print("go down")
		animation_player.play("go_down")
		await animation_player.animation_finished
		collision_shape_2d.set_deferred("disabled", true)
		await get_tree().create_timer(3).timeout
		collision_shape_2d.set_deferred("disabled", false)
		
	elif animatable_body_2d.position.y <= 109:
		print("go up")
		animation_player.play("go up")
		await animation_player.animation_finished
		collision_shape_2d.set_deferred("disabled", true)
		await get_tree().create_timer(3).timeout
		collision_shape_2d.set_deferred("disabled", false)
