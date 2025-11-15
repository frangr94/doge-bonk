extends Node

signal scene_changed
func change_scene(path: String, player_position: Vector2):
	get_tree().change_scene_to_file(path)
	SaveLoad.SaveFileData.player_position = player_position
	SaveLoad.SaveFileData.current_scene = path
	emit_signal("scene_changed")
