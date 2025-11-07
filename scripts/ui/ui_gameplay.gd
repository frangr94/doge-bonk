extends CanvasLayer

@onready var hp_label: Label = $hp_label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if hp_label:
		print("hp label lista")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	hp_label.text = "hp: " + str(GameManager.player_hp)
