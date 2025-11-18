extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $killzone
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var collision_shape_2d: CollisionShape2D = $killzone/CollisionShape2D
@onready var slash_explosion_pixeler: CPUParticles2D = $slash_explosion_pixeler

# properties

var SPEED = EnemySpeedController.rampaging_pixeler
var direction = 1
var hp = 1


func _on_area_entered(area: Area2D) -> void:
	# take sword damage
	if area.is_in_group("sword"):
		audio_stream_player.play()
		animated_sprite_2d.play("hit")
		slash_explosion_pixeler.emitting = true
		collision_shape_2d.set_deferred("disabled", true)
		await animated_sprite_2d.animation_finished
		await audio_stream_player.finished
		collision_shape_2d.set_deferred("disabled", false)
		hp -= 1
		#animated_sprite_2d.play("run")

# take kamehameha damage
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("kamehameha"):
		audio_stream_player.play()
		await audio_stream_player.finished
		hp -= 2

# movement
func _physics_process(delta: float) -> void:
	var SPEED = EnemySpeedController.rampaging_pixeler
	if ray_cast_up.is_colliding():
		direction = 1
		#animated_sprite_2d.flip_h = false
	if ray_cast_down.is_colliding():
		direction = -1
		#animated_sprite_2d.flip_h = true
	position.y += direction * SPEED * delta
	
	# death
	if hp <= 0:
		killzone.queue_free()
		queue_free()
