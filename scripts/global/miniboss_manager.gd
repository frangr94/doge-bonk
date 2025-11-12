extends Node

# check if is alive:
var pixeler_big_tutorial_defeated = false

func _ready():
	SaveLoad._load()
	pixeler_big_tutorial_defeated = SaveLoad.SaveFileData.pixeler_big_tutorial_defeated
