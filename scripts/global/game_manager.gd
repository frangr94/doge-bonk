extends Node

var player_hp: int = 3
var attack_unlock: bool = false
var dash_unlock: bool = false
var double_jump_unlock: bool = false
var kamehameha_unlock: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("GameManager: -> ready")
	print("hp: "+ str(player_hp))
	print("roll_unlock: "+ str(dash_unlock))
	print("double_jump_unlock: "+ str(double_jump_unlock) )
	print("attack_unlock: " + str(attack_unlock))

# manages player hp
signal health_changed
func loose_hp():
	player_hp -= 1
	emit_signal("health_changed")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	if player_hp == 0:
		get_tree().change_scene_to_file("res://scenes/ui/death_screen.tscn")
