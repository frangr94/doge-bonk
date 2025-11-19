extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $killzone
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var collision_shape_2d: CollisionShape2D = $killzone/CollisionShape2D
@onready var slash_explosion_pixeler: CPUParticles2D = $slash_explosion_pixeler

# properties
var direction = 1
var hp = 2
# movement
func _physics_process(delta: float) -> void:
	var SPEED = EnemySpeedController.rampaging_pixeler
	if ray_cast_up.is_colliding():
		direction = 1
	if ray_cast_down.is_colliding():
		direction = -1
	position.y += direction * SPEED * delta
	
	# death
	if hp <= 0:
		killzone.queue_free()
		queue_free()
