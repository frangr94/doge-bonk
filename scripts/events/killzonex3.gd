extends Area2D

@onready var hurt: AudioStreamPlayer = $hurt

func _on_body_entered(body: Node2D) -> void:
	GameManager.loose_hp()
	hurt.play()
	GameManager.loose_hp()
	hurt.play()
	GameManager.loose_hp()
	hurt.play()
	pass # Replace with function body.
