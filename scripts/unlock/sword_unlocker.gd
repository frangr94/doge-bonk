extends Area2D

@onready var interactable: Area2D = $interactable

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	GameManager.attack_unlock = true
	interactable.is_interactable = false
	print("attack_unlock: " + str(GameManager.attack_unlock))
	queue_free()
