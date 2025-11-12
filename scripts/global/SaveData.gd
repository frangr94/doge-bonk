extends Resource
class_name SaveDataResource

# hp
@export var max_hp: int = 3
@export var player_hp: int = 3

# abilities
@export var attack_unlock: bool = false
@export var dash_unlock: bool = false
@export var double_jump_unlock: bool = false
@export var kamehameha_unlock: bool = false

#player position
@export var player_position: Vector2 = Vector2(0,0)

# minibosses
@export var pixeler_big_tutorial_defeated: bool = false
