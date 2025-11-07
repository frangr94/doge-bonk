extends Node

var player_hp = 3
var attack_unlock = false
var dash_unlock = true
var double_jump_unlock = true
var pogo_unlock = true

@onready var hp_label: Label = $CanvasLayer/hp_label







# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("GameManager: -> ready")
	print("hp: "+ str(player_hp))
	print("roll_unlock: "+ str(dash_unlock))
	print("double_jump_unlock: "+ str(double_jump_unlock) )
	print("attack_unlock: " + str(attack_unlock))

# manages player hp

func loose_hp():
	player_hp -= 1
	print(player_hp)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if hp_label && player_hp:
		hp_label.text = "hola"
	if player_hp == 0:
		get_tree().change_scene_to_file("res://scenes/ui/death_screen.tscn")
