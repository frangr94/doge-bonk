extends Area2D

func _on_body_entered(body: Node2D) -> void:
	SceneLoader.change_scene("res://scenes/levels/tutorial.tscn", Vector2(290,40))
