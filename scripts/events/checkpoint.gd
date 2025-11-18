extends Area2D
@onready var checkpoint_save_sound: AudioStreamPlayer = $checkpoint_save_sound


func _on_body_entered(body: Node2D) -> void:
	checkpoint_save_sound.play()
	SaveLoad.SaveFileData.player_position = global_position
