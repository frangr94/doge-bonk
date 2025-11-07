extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $killzone
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# properties

var hp = 2

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		audio_stream_player.play()
		await audio_stream_player.finished
		hp -= 1


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("kamehameha"):
		audio_stream_player.play()
		await audio_stream_player.finished
		hp -= 2
		
func _process(_delta: float) -> void:
	if hp <= 0:
		killzone.queue_free()
		queue_free()
