extends Node

var max_hp: int = 3
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
	player_hp = SaveLoad.SaveFileData.player_hp
	attack_unlock = SaveLoad.SaveFileData.attack_unlock
	dash_unlock = SaveLoad.SaveFileData.dash_unlock
	double_jump_unlock = SaveLoad.SaveFileData.double_jump_unlock
	kamehameha_unlock = SaveLoad.SaveFileData.kamehameha_unlock
	bounce_unlock = SaveLoad.SaveFileData.bounce_unlock
	print("GameManager: -> ready")
	print("hp: "+ str(player_hp))
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
	player_hp = max_hp
	emit_signal("health_changed")
	
func SaveGame():
		SaveLoad.SaveFileData.max_hp = GameManager.max_hp
		if player_hp <= 0:
			SaveLoad.SaveFileData.player_hp = GameManager.max_hp
		else:
			SaveLoad.SaveFileData.player_hp = GameManager.player_hp
		SaveLoad.SaveFileData.attack_unlock = GameManager.attack_unlock
		SaveLoad.SaveFileData.dash_unlock = GameManager.dash_unlock
		SaveLoad.SaveFileData.double_jump_unlock = GameManager.double_jump_unlock
		SaveLoad.SaveFileData.kamehameha_unlock = GameManager.kamehameha_unlock
		SaveLoad._save()

	

func _process(_delta: float) -> void:
	if player_hp <= 0:
		SaveGame()
		get_tree().change_scene_to_file("res://scenes/ui/death_screen.tscn")
		
