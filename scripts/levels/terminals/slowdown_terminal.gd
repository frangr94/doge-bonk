extends AnimatedSprite2D

@onready var interactable: Area2D = $interactable


func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	print("slowdown terminal activate")
	EnemySpeedController.rampaging_pixeler = EnemySpeedController.rampaging_pixeler / 3
	await get_tree().create_timer(3).timeout
	EnemySpeedController.rampaging_pixeler = EnemySpeedController.rampaging_pixeler * 3
	
	
