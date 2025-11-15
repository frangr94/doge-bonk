extends AnimatedSprite2D

@onready var interactable: Area2D = $interactable
const PLAYER = preload("uid://yshyoholm5s8")

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	print("Save game")
	GameManager.port_heal()
	SaveLoad.SaveFileData.current_scene = get_tree().current_scene.scene_file_path
	print(str(get_tree().current_scene.scene_file_path))
	SaveLoad.SaveFileData.player_position = global_position
	SaveLoad._save()

	
