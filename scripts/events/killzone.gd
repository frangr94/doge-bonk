extends Area2D

@onready var player: CharacterBody2D = $"../player"

func _on_body_entered(body) -> void:
	if player:
		player.global_position = Vector2(0,0)
		GameManager.loose_hp()
	else:
		GameManager.loose_hp()
