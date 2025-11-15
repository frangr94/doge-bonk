extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if SaveLoad.SaveFileData.tutorial_barrier_merlin == true:
		pass
	else:
		queue_free()
