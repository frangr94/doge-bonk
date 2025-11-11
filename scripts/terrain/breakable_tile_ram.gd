extends Area2D

var hp = 3

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		hp -= 1
		
	if hp <= 0:
		queue_free()
