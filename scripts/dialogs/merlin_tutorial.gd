extends Area2D


@onready var tutorial_barrier: StaticBody2D = $"../tutorial_barrier"

@onready var interactable: Area2D = $interactable
const MERLIN_INTRODUCTION = preload("uid://cgedpabtuxme2")

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	DialogueManager.show_dialogue_balloon(MERLIN_INTRODUCTION)
	if tutorial_barrier:
		tutorial_barrier.queue_free()
		SaveLoad.SaveFileData.tutorial_barrier_merlin = false
