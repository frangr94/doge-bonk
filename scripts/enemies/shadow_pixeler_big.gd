extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone_3: Area2D = $killzone3

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var collision_shape_2d: CollisionShape2D = $killzone3/CollisionShape2D
@onready var slash_explosion_pixeler_big: CPUParticles2D = $slash_explosion_pixeler_big

@onready var self_chip_shard: Area2D = $"../../self_chip_shard"

# properties
var SPEED = 50
var direction = 1
var hp = 2

func _ready() -> void:
	if MinibossManager.pixeler_big_tutorial_defeated == false:
		pass
	else:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	# take sword damage
	if area.is_in_group("sword"):
		audio_stream_player.play()
		animated_sprite_2d.play("hit")
		if area.is_in_group("pogo"):
			var player = area.get_parent() as CharacterBody2D
			if player and player.has_method("bounce"):
				player.bounce()
		slash_explosion_pixeler_big.emitting = true
		collision_shape_2d.set_deferred("disabled", true)
		await animated_sprite_2d.animation_finished
		await audio_stream_player.finished
		collision_shape_2d.set_deferred("disabled", false)
		hp -= 1
		animated_sprite_2d.play("run")

# take kamehameha damage
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("kamehameha"):
		audio_stream_player.play()
		await audio_stream_player.finished
		hp -= 2

# movement
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = true
	position.x += direction * SPEED * delta
	
	# death
	if hp <= 0:
		MinibossManager.pixeler_big_tutorial_defeated = true
		SaveLoad.SaveFileData.pixeler_big_tutorial_defeated = true
		queue_free()
