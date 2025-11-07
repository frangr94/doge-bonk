extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $killzone
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# properties
var SPEED = 60
var direction = 1
var hp = 2
var dead = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# move and colide with objects
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x += direction * SPEED * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		audio_stream_player.play()
		SPEED = 0
		killzone.monitoring = false
		await get_tree().create_timer(0.4).timeout
		killzone.monitoring = true
		SPEED = 60
		hp -= 1
		if hp == 0:
			killzone.queue_free()
			SPEED = 0
			queue_free()
		else:
			animated_sprite_2d.play("idle")
