extends CanvasLayer

@onready var chip_shard_amount: Label = $GridContainer/chip_shard_amount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if chip_shard_amount:
		chip_shard_amount.text = str(SaveLoad.SaveFileData.self_shard_amount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
