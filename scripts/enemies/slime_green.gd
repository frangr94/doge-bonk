extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $killzone

var hp = 2
var dead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		animated_sprite_2d.play("hurt")
		await animated_sprite_2d.animation_finished
		hp -= 1
		if hp == 0:
			killzone.queue_free()
			dead = true
			animated_sprite_2d.play("dead")
			await get_tree().create_timer(3).timeout
			queue_free()
		else:
			animated_sprite_2d.play("idle")
