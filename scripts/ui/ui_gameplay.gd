extends CanvasLayer

# heart bar
var full_heart = preload("res://assets/sprites/hp-heart.png")

@onready var heart_bar: HBoxContainer = $HBoxContainer

func update_hearts():
	for child in heart_bar.get_children():
		child.queue_free()
	for i in range(GameManager.player_hp):
		var heart = TextureRect.new()
		heart.texture = full_heart
		heart_bar.add_child(heart)


func _ready() -> void:
	if not GameManager.health_changed.is_connected(Callable(self, "update_hearts")):
		GameManager.health_changed.connect(Callable(self, "update_hearts"))
		update_hearts()
