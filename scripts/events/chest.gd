extends Area2D

@onready var interactable: Area2D = $interactable


func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	print("chest open")
