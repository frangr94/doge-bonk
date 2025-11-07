extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	sprite.play("slash")  # or whatever your animation is named
	print("slash")
	sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))
	await  sprite.animation_finished
	queue_free()
	
