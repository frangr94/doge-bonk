extends AnimatedSprite2D

@onready var interactable: Area2D = $interactable


func _ready() -> void:
	interactable.interact = _on_interact
	
func _on_interact():
	GameManager.gravity_inverted = -GameManager.gravity_inverted
	await get_tree().create_timer(5). timeout
	GameManager.gravity_inverted = -GameManager.gravity_inverted
