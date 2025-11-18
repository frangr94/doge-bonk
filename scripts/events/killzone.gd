extends Area2D



func _on_body_entered(_body) -> void:
	GameManager.loose_hp(1)
