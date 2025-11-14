extends Node

var max_hp: int
var player_hp: int
var attack_unlock: bool
var dash_unlock: bool
var double_jump_unlock: bool
var kamehameha_unlock: bool
var bounce_unlock: bool


var jump_count = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# ADD LOAD
	SaveLoad._load()
	max_hp = SaveLoad.SaveFileData.max_hp
	player_hp = SaveLoad.SaveFileData.max_hp
	attack_unlock = SaveLoad.SaveFileData.attack_unlock
	dash_unlock = SaveLoad.SaveFileData.dash_unlock
	double_jump_unlock = SaveLoad.SaveFileData.double_jump_unlock
	kamehameha_unlock = SaveLoad.SaveFileData.kamehameha_unlock
	bounce_unlock = SaveLoad.SaveFileData.bounce_unlock
	print("GameManager: -> ready")
	print("hp: "+ str(player_hp))
	print("max_hp: " +str(max_hp))
	print("roll_unlock: "+ str(dash_unlock))
	print("double_jump_unlock: "+ str(double_jump_unlock) )
	print("attack_unlock: " + str(attack_unlock))
	print("kamehameha unlock: "+str(kamehameha_unlock))


# manages player hp
signal health_changed
func loose_hp():
	player_hp -= 1
	emit_signal("health_changed")

func port_heal():
	player_hp = SaveLoad.SaveFileData.max_hp
	emit_signal("health_changed")

		
signal pick_shard
func self_shard_pick():
	emit_signal("pick_shard")



func _process(_delta: float) -> void:
	if player_hp <= 0:
		player_hp = SaveLoad.SaveFileData.max_hp
		SaveLoad._save()
		get_tree().change_scene_to_file("res://scenes/ui/death_screen.tscn")
	
