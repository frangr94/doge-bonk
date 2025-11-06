extends Node

var player_hp = 3

func loose_hp():
	player_hp -= 1
	print(player_hp)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_hp == 0:
		get_tree().change_scene_to_file("res://scenes/ui/death_screen.tscn")
