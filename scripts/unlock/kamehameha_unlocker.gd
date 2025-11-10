extends Area2D

@onready var interactable: Area2D = $interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $interactable/CollisionShape2D

func _ready() -> void:
	interactable.interact = _on_interact
	if GameManager.kamehameha_unlock == true:
		sprite_2d.visible = false
		collision_shape_2d.disabled = true

func _on_interact():
	GameManager.kamehameha_unlock = true
	interactable.is_interactable = false
	print("kamehameha_unlock: " + str(GameManager.attack_unlock))
	queue_free()
