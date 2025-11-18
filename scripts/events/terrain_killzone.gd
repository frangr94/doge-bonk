extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and GameManager.player_hp > 1:
		GameManager.loose_hp(1)
		body.global_position = SaveLoad.SaveFileData.player_position
	else:
		GameManager.loose_hp(1)
