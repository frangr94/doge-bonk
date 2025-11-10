extends Node

const save_location = "res://SaveFile.tres"

var SaveFileData: SaveDataResource = SaveDataResource.new()

func _save():
	ResourceSaver.save(SaveFileData, save_location)
	
func _load():
	if FileAccess.file_exists(save_location):
		SaveFileData = ResourceLoader.load(save_location).duplicate(true)
		print(SaveFileData)
	pass
