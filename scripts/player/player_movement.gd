extends CharacterBody2D

@onready var player: CharacterBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $attack_area/CollisionShape2D
@onready var sword_slash_sound: AudioStreamPlayer = $sword_slash_sound
@onready var kamehameha = preload("uid://cvpm5nwrr1npl")
@onready var kamehameha_position: Marker2D = $kamehameha_position
@onready var attack: AnimatedSprite2D = $attack
@onready var jump: CPUParticles2D = $jump
@onready var attack_particle: CPUParticles2D = $attack_particle
@onready var coyote_time: Timer = $coyote_time


# running and jump speed
const SPEED = 210
const JUMP_VELOCITY = -300.0


# check if player is attacking
var isAttacking = false
var canAttack = true
const ATTACK_COOLDOWN := 0.3  # seconds between attacks


# check if player is rolling
var isDashing = false

# dash cooldown
var canDash = true
const DASH_COOLDOWN = 0.5 # seconds

# double jump controller
var MAX_JUMPS = 1
var jump_count = GameManager.jump_count
# kamahameha controller
var isShooting = false

func _ready():
	if SaveLoad.SaveFileData.player_position:
		global_position = SaveLoad.SaveFileData.player_position
	else:
		global_position = Vector2(-1140,80)

func bounce(strenght: float = 300):
	velocity.y = -strenght

func get_hurt():
	animated_sprite_2d.play("hit")

# dash function
func start_dash() -> void:
	if GameManager.dash_unlock == true and canDash == true:
		canDash = false
		isDashing = true
		animated_sprite_2d.play("dash")
		player.set_collision_layer_value(7, false) # get iframes
		# freeze vertical velocity to make a straightline while dashing
		velocity.y = 0

		# control dash speed and lenght
		if animated_sprite_2d.flip_h:
			velocity.x = -SPEED * 1.5
		else:
			velocity.x = SPEED * 1.5

		await animated_sprite_2d.animation_finished
		player.set_collision_layer_value(7, true) # disable iframes
		isDashing = false
		await get_tree().create_timer(DASH_COOLDOWN).timeout
		canDash = true


func _physics_process(delta: float) -> void:
	if not is_on_floor() and isDashing == false:
		velocity += get_gravity() * delta

	# jump controller
	if GameManager.double_jump_unlock == true:
		MAX_JUMPS = 2
	else:
		MAX_JUMPS = 1

	if Input.is_action_just_pressed("jump") and GameManager.jump_count < MAX_JUMPS:
		if GameManager.jump_count == 1:
			jump.emitting = true
			velocity.y = JUMP_VELOCITY
			GameManager.jump_count += 1
		elif GameManager.jump_count == 0:
			velocity.y = JUMP_VELOCITY
			GameManager.jump_count +=1
	elif Input.is_action_just_pressed("jump") and is_on_floor() and GameManager.jump_count >= MAX_JUMPS:
		GameManager.jump_count = 0
		velocity.y = JUMP_VELOCITY
		GameManager.jump_count += 1
	


	# attack controller
	if Input.is_action_just_pressed("attack") and not isAttacking and canAttack and not isDashing and GameManager.attack_unlock == true:
		isAttacking = true
		canAttack = false
		attack.play("default")
		attack_particle.emitting = true
		sword_slash_sound.play()
		$attack_area/CollisionShape2D.disabled = false
	
		isAttacking = false
		await get_tree().create_timer(ATTACK_COOLDOWN).timeout
		canAttack = true
	else:
		if not isAttacking:
			$attack_area/CollisionShape2D.disabled = true

	if Input.is_action_just_pressed("dash") and not isDashing and not isAttacking:
		velocity.x = 0
		start_dash()
	if isAttacking:
		pass
	elif isDashing:
		# Maintain roll velocity
		pass

	else:
		var direction := Input.get_axis("move_left", "move_right")
		var deadzone = 0.5
		
		
		# controller deadzone
		if abs(direction) < deadzone:
			direction = 0

		if direction > 0:
			if abs(velocity.x) > 10 and not isAttacking:
				animated_sprite_2d.flip_h = false
				collision_shape_2d.position = Vector2(10, 0)
				kamehameha_position.scale.x = 1
				kamehameha_position.position = Vector2(4, 2)
				attack.scale.x = 1
				attack.position = Vector2(10,0)
				attack_particle.scale.x = 1
		elif direction < 0:
			if abs(velocity.x) > 10 and not isAttacking:
				animated_sprite_2d.flip_h = true
				collision_shape_2d.position = Vector2(-10, 0)
				kamehameha_position.scale.x = -1
				kamehameha_position.position = Vector2(-4, 2)
				attack.scale.x = -1
				attack.position = Vector2(-10,0)
				attack_particle.scale.x = -1

		if direction !=0:
			var target_speed := direction * SPEED
			velocity.x = move_toward(velocity.x, target_speed, SPEED * delta * 10)

		else:
			velocity.x = 0
			if not isAttacking and is_on_floor():
				#velocity.x = move_toward(velocity.x, 0, SPEED)
				animated_sprite_2d.play("idle")
		
		if direction != 0 && is_on_floor():
			animated_sprite_2d.play("run")
			
		elif velocity.y !=0:
			animated_sprite_2d.play("jump")
		
		else:
			animated_sprite_2d.play("idle")

		# kamehameha
		if Input.is_action_just_pressed("shoot") and not isAttacking and GameManager.kamehameha_unlock == true and not isShooting:
			isShooting = true
			var k = kamehameha.instantiate()
			k.global_position = kamehameha_position.global_position
			k.vel = kamehameha_position.scale.x
			get_parent().add_child(k)
			await get_tree().create_timer(2).timeout
			isShooting = false
		
	move_and_slide()
	
	# reset jumps
	if is_on_floor():
		jump_count = 0
