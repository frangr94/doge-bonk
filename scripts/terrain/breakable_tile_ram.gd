extends Area2D

@onready var break_tile: AudioStreamPlayer = $break_tile

@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var collision_shape_2d_area: CollisionShape2D = $CollisionShape2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

var hp = 3

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		break_tile.play()
		hp -= 1
		break_tile.play()
		cpu_particles_2d.emitting = true
		
	if hp <= 0:
		break_tile.play()
		collision_shape_2d.set_deferred("disabled", true)
		collision_shape_2d_area.set_deferred("disabled", true)
		sprite_2d.visible = false
		cpu_particles_2d.emitting = true

		#queue_free()
