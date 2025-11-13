extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("checkpoint")
	print(get_tree().current_scene.get_path())
	SaveLoad.SaveFileData.player_position = global_position
	SaveLoad._save()
