extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $killzone
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# properties

var hp = 2

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		audio_stream_player.play()
		killzone.monitoring = false
		await get_tree().create_timer(0.4).timeout
		killzone.monitoring = true
		hp -= 1
		if hp == 0:
			killzone.queue_free()
			queue_free()
		else:
			animated_sprite_2d.play("idle")
