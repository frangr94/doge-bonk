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
@export var bounce_unlock: bool = false

#player position
@export var player_position: Vector2 = Vector2(0,0)

# minibosses
@export var pixeler_big_tutorial_defeated: bool = false

# barriers
@export var tutorial_barrier_merlin: bool = true

# items
# chip shards
@export var self_shard_amount: int = 0
@export var chip_shard_1: bool = false
@export var chip_shard_2: bool = false
@export var chip_shard_3: bool = false
@export var chip_shard_4: bool = false
@export var chip_shard_5: bool = false
@export var chip_shard_6: bool = false
@export var chip_shard_7: bool = false
@export var chip_shard_8: bool = false
@export var chip_shard_9: bool = false
@export var chip_shard_10: bool = false
@export var chip_shard_11: bool = false
@export var chip_shard_12: bool = false
