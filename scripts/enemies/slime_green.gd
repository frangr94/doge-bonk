extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $killzone
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# properties
var SPEED = 60
var direction = 1
var hp = 5
var dead = false

# pushback
var pushback_velocity := Vector2.ZERO
var pushback_decay := 300.0  # higher = faster stop




func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		SPEED = 0
		animated_sprite_2d.play("hurt")
		audio_stream_player.play()
		await get_tree().create_timer(0.5).timeout
		SPEED = 60
		hp -= 1
		animated_sprite_2d.play("idle")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("kamehameha"):
		audio_stream_player.play()
		await audio_stream_player.finished
		hp -= 2

func _process(delta: float) -> void:
	# move and colide with objects
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x += direction * SPEED * delta

	# death
	if hp <= 0:
		killzone.queue_free()
		queue_free()
