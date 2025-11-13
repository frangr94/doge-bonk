extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var interactable: Area2D = $interactable
@onready var collision_shape_2d: CollisionShape2D = $interactable/CollisionShape2D

const CHIP_NUMBER = 1

func _ready() -> void:
	interactable.interact = _on_interact
	if SaveLoad.SaveFileData.chip_shard_2 == false:
		pass
	else:
		sprite_2d.visible = false
		collision_shape_2d.disabled = true
	
func _on_interact():
	print("self chip interact")
	if SaveLoad.SaveFileData.self_shard_amount >= 2:
		GameManager.max_hp += 1
		SaveLoad.SaveFileData.max_hp += 1
		SaveLoad.SaveFileData.player_hp += 1
		SaveLoad.SaveFileData.self_shard_amount = 0
		SaveLoad.SaveFileData.chip_shard_2 = true
		GameManager.port_heal()
		SaveLoad._save()
		queue_free()
		print(SaveLoad.SaveFileData.max_hp)
	else:
		SaveLoad.SaveFileData.self_shard_amount += 1
		print("has "+ str(SaveLoad.SaveFileData.self_shard_amount) + "shards" )
		SaveLoad.SaveFileData.chip_shard_2 = true
		SaveLoad._save()
		queue_free()
