extends Area2D

func _on_body_entered(body: Node2D) -> void:
	GameManager.loose_hp()
	print("fell out of terrain")
