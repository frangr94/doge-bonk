extends CharacterBody2D

@onready var player: CharacterBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $attack_area/CollisionShape2D
@onready var sword_slash_sound: AudioStreamPlayer = $sword_slash_sound

# running and jump speed
const SPEED = 190.0
const JUMP_VELOCITY = -300.0

# check if player is attacking
var isAttacking = false

# check if player is rolling
var isDashing = false

# dash cooldown
var canDash = true
const DASH_COOLDOWN = 0.5 #seconds

# double jump controller

var MAX_JUMPS = 1
var jump_count = 0



func start_dash() -> void:
	if GameManager.dash_unlock == true && canDash == true:
		canDash = false
		isDashing = true
		animated_sprite_2d.play("dash")
		player.set_collision_layer_value(7, false) # get iframes
		
		# freeze vertical velocity to make a straightline while dashing
		velocity.y = 0

		if animated_sprite_2d.flip_h:
			velocity.x = -SPEED * 1.8
		else:
			velocity.x = SPEED * 1.8
		
		await animated_sprite_2d.animation_finished
		player.set_collision_layer_value(7, true) # disable iframes
		isDashing = false
		await get_tree().create_timer(DASH_COOLDOWN).timeout # insert dash cooldown
		canDash = true


func _physics_process(delta: float) -> void:
	if not is_on_floor() && isDashing == false:
		velocity += get_gravity() * delta

	# jump controller
	if GameManager.double_jump_unlock == true:
		MAX_JUMPS = 2
	else:
		MAX_JUMPS = 1
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		animated_sprite_2d.play("jump")

	if Input.is_action_just_pressed("attack") and not isAttacking and not isDashing and GameManager.attack_unlock == true:
		isAttacking = true
		animated_sprite_2d.play("attack")
		sword_slash_sound.play()
		$attack_area/CollisionShape2D.disabled = false
		await animated_sprite_2d.animation_finished
		isAttacking = false
	else:
		if not isAttacking:
			$attack_area/CollisionShape2D.disabled = true

	if Input.is_action_just_pressed("dash") and not isDashing and not isAttacking:
		start_dash()

	if isAttacking:
		#var direction := Input.get_axis("move_left", "move_right")
		#if direction > 0:
			#animated_sprite_2d.flip_h = false
			#collision_shape_2d.position = Vector2(8,0)
		#elif direction < 0:
			#animated_sprite_2d.flip_h = true
			#collision_shape_2d.position = Vector2(-8,0)
		velocity.x = 0
	elif isDashing:
		# Maintain roll velocity
		pass
	else:
		var direction := Input.get_axis("move_left", "move_right")
		if direction > 0:
			animated_sprite_2d.flip_h = false
			collision_shape_2d.position = Vector2(8,0)
		elif direction < 0:
			animated_sprite_2d.flip_h = true
			collision_shape_2d.position = Vector2(-8,0)

		if direction:
			velocity.x = direction * SPEED
			animated_sprite_2d.play("run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite_2d.play("idle")

	move_and_slide()
	# reset jumps
	if is_on_floor():
		jump_count = 0
