extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		GameManager.loose_hp()
		body.global_position = SaveLoad.SaveFileData.player_position
