extends Area2D

@onready var static_body_2d: StaticBody2D = $"../StaticBody2D"

@onready var interactable: Area2D = $interactable
const MERLIN_INTRODUCTION = preload("uid://cgedpabtuxme2")

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	DialogueManager.show_dialogue_balloon(MERLIN_INTRODUCTION)
	static_body_2d.queue_free()
	pass
