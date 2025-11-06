extends Node

var player_hp = 3
var roll_unlock = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("GameManager start")

# manages player hp
func loose_hp():
	player_hp -= 1
	print(player_hp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_hp == 0:
		get_tree().change_scene_to_file("res://scenes/ui/death_screen.tscn")
