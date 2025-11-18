extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var bounce_sound: AudioStreamPlayer = $bounce_sound

func _on_area_entered(area: Area2D):
	if area.is_in_group("sword") and GameManager.bounce_unlock == true:
		
		var player = area.get_parent() as CharacterBody2D
		if player and player.has_method("bounce"):
			bounce_sound.play()
			animated_sprite_2d.play("hit")
			
			player.bounce()
			if GameManager.jump_count >= 1:
				GameManager.jump_count -= 1
