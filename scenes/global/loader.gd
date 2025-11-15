extends Node

var current_scene = null

func _ready():
	if SaveLoad and SaveLoad.SaveFileData:
		current_scene = SaveLoad.SaveFileData.current_scene
	
	if current_scene:
		print(current_scene)
		call_deferred("_change_scene", current_scene)
	else:
		call_deferred("_change_scene", "res://scenes/levels/tutorial.tscn")

func _change_scene(path: String):
	if path:
		get_tree().change_scene_to_file(path)
	else:
		print("no path assigned to _change_scene")
	
	

		
		
