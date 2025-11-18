extends AnimatedSprite2D

@onready var interactable: Area2D = $interactable
@onready var save_sound: AudioStreamPlayer = $save_sound

const COOLDOWN: float = 2
var usable: bool = true

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	if usable == true:
		usable = false
		GameManager.port_heal()
		SaveLoad.SaveFileData.current_scene = get_tree().current_scene.scene_file_path
		SaveLoad.SaveFileData.player_position = global_position
		save_sound.play()
		SaveLoad._save()
		await get_tree().create_timer(2).timeout
		usable = true
	
