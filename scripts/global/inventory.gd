extends CanvasLayer


@onready var inventory: CanvasLayer = $"."
@onready var chip_shard_amount: Label = $NinePatchRect/GridContainer/chip_shard_amount

var inventory_open = false

func update_chip_shard_amount():
	if chip_shard_amount:
		chip_shard_amount.text = str(SaveLoad.SaveFileData.self_shard_amount)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if chip_shard_amount:
		chip_shard_amount.text = str(SaveLoad.SaveFileData.self_shard_amount)
	else:
		pass
	if not GameManager.pick_shard.is_connected(Callable(self, "update_chip_shard_amount")):
		GameManager.pick_shard.connect(Callable(self,"update_chip_shard_amount"))
		update_chip_shard_amount()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		inventory.visible = !inventory.visible
		inventory_open = inventory.visible
		
		
