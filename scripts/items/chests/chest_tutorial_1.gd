extends Area2D

@onready var interactable: Area2D = $interactable
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var self_chip_obtain: NinePatchRect = $self_chip_obtain


func _ready() -> void:
	interactable.interact = _on_interact
	if SaveLoad.SaveFileData.tutorial_chest_1 == false:
		animated_sprite.play("closed")
	else:
		animated_sprite.play("open")
	

func _on_interact():

	if SaveLoad.SaveFileData.tutorial_chest_1 == false:
		SaveLoad.SaveFileData.tutorial_chest_1 = true
		SaveLoad.SaveFileData.self_shard_amount += 1
		SaveLoad._save()
		if SaveLoad.SaveFileData.self_shard_amount >=3:
			SaveLoad.SaveFileData.max_hp += 1
			SaveLoad.SaveFileData.player_hp = SaveLoad.SaveFileData.max_hp
			GameManager.port_heal()
			SaveLoad._save()

			SaveLoad.SaveFileData.self_shard_amount = 0
		animated_sprite.play("open")
	else:
		pass
