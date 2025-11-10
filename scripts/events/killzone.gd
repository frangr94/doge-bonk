extends Area2D

@onready var hurt: AudioStreamPlayer = $hurt

func _on_body_entered(_body) -> void:
	GameManager.loose_hp()
	hurt.play()
