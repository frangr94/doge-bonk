extends Area2D

func _on_body_entered(body: Node2D) -> void:
	SceneLoader.change_scene("res://scenes/levels/dusty_bottom.tscn", Vector2(-30,0))
