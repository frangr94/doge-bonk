extends Area2D

@onready var player: CharacterBody2D = $"../player"

@onready var hurt: AudioStreamPlayer = $hurt

func _on_body_entered(_body) -> void:
	if player:
		player.global_position = Vector2(0,0)
		hurt.play()
		GameManager.loose_hp()
	else:
		GameManager.loose_hp()
		hurt.play()
