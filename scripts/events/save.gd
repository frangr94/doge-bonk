extends AnimatedSprite2D

@onready var interactable: Area2D = $interactable

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	print("Save game")
	GameManager.port_heal()
	print(get_tree().current_scene.get_path())
	SaveLoad.SaveFileData.max_hp = GameManager.max_hp
	SaveLoad.SaveFileData.player_hp = GameManager.player_hp
	SaveLoad.SaveFileData.attack_unlock = GameManager.attack_unlock
	SaveLoad.SaveFileData.dash_unlock = GameManager.dash_unlock
	SaveLoad.SaveFileData.double_jump_unlock = GameManager.double_jump_unlock
	SaveLoad.SaveFileData.kamehameha_unlock = GameManager.kamehameha_unlock
	SaveLoad.SaveFileData.player_position = global_position
	SaveLoad._save()

	
