extends Area2D

func _on_area_entered(area: Area2D):
	if area.is_in_group("sword") and GameManager.bounce_unlock == true:
		var player = area.get_parent() as CharacterBody2D
		if player and player.has_method("bounce"):
			player.bounce()
			if GameManager.jump_count >= 1:
				GameManager.jump_count -= 1
