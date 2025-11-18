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
@onready var coyote_time: float = 0.125
@onready var shuriken = preload("uid://b811meofd7bjx")
@onready var shuriken_position: Marker2D = $shuriken_position
@onready var inventory: CanvasLayer = $inventory
@onready var dash_particle: CPUParticles2D = $dash_particle
@onready var dash_sound: AudioStreamPlayer = $dash
#@onready var player_hitbox: CollisionShape2D = $hitbox
@onready var invincibility_effect: CPUParticles2D = $invincibility_effect
@onready var hurt_sound: AudioStreamPlayer = $hurt_sound
@onready var terrain_hitbox: CollisionShape2D = $CollisionShape2D
@onready var hit_effect: CPUParticles2D = $hit_effect
@onready var heal_effect: CPUParticles2D = $heal_effect


# running and jump speed
const SPEED = 210
const JUMP_VELOCITY = -300.0

# gravity
const GRAVITY := 1000
const FALL_GRAVITY := 400


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
var can_jump: bool = true
var inventory_open = false


# kamahameha controller
var isShooting = false

# respawn
func _ready():

	inventory.visible = false
	if SaveLoad.SaveFileData.player_position:
		global_position = SaveLoad.SaveFileData.player_position
	else:
		global_position = Vector2(0,0)

	if not GameManager.health_decreased.is_connected(Callable(self, "hit_invincibility")):
		GameManager.health_decreased.connect(Callable(self, "hit_invincibility"))
		
	if not GameManager.health_increased.is_connected(Callable(self, "heal_at_port")):
		GameManager.health_increased.connect(Callable(self, "heal_at_port"))			
		
func hit_invincibility():
	hurt_sound.play()
	hit_effect.emitting = true
	
func heal_at_port():
	heal_effect.emitting = true

func bounce(strenght: float = 250):
	velocity.y = -strenght

func get_hurt():
	animated_sprite_2d.play("hit")
	

func start_jump():
	velocity.y = JUMP_VELOCITY
	GameManager.jump_count += 1
	

func coyote_timer():
	can_jump = false

# dash function
func start_dash() -> void:
	if GameManager.dash_unlock == true and canDash == true:
		canDash = false
		isDashing = true
		if is_on_floor() or is_on_ceiling():
			animated_sprite_2d.play("dash")
			dash_sound.play()
		else:
			animated_sprite_2d.play("air_dash")
			dash_particle.emitting = true

			dash_sound.play()

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

func def_gravity(velocity: Vector2):
	if velocity.y < 0:
		return GRAVITY * GameManager.gravity_inverted
	else:
		return FALL_GRAVITY * GameManager.gravity_inverted
	pass

func _physics_process(delta: float) -> void:
	
	if GameManager.dialogue_stopper == true:
		return

	#################### JUMP #################################
	if not is_on_floor() and isDashing == false:
		if can_jump:
			get_tree().create_timer(coyote_time).timeout.connect(coyote_timer)
		velocity.y += def_gravity(velocity) * delta
	else:
		can_jump = true
	# jump controller
	if GameManager.double_jump_unlock == true:
		MAX_JUMPS = 2
	else:
		MAX_JUMPS = 1

	if Input.is_action_just_pressed("jump") and GameManager.jump_count < MAX_JUMPS and GameManager.gravity_inverted == 1:
		if GameManager.jump_count == 1:
			jump.emitting = true
			start_jump()
		elif GameManager.jump_count == 0:
			start_jump()
	elif Input.is_action_just_pressed("jump") and can_jump and GameManager.jump_count >= MAX_JUMPS and GameManager.gravity_inverted == 1:
		GameManager.jump_count = 0
		start_jump()
	
	if Input.is_action_just_released("jump")and velocity.y < 0 and GameManager.gravity_inverted == 1:
		velocity.y = JUMP_VELOCITY / 3



############################# ATTACK ###########################
	if Input.is_action_just_pressed("attack") and not isAttacking and canAttack and not isDashing and GameManager.attack_unlock == true:
		sword_slash_sound.play()
		attack.play("default")
		isAttacking = true
		canAttack = false
		attack_particle.emitting = true
		$attack_area/CollisionShape2D.disabled = false
		isAttacking = false
		await get_tree().create_timer(ATTACK_COOLDOWN).timeout
		canAttack = true
	else:
		if not isAttacking:
			$attack_area/CollisionShape2D.disabled = true


############################ DASH ###############################################
	if Input.is_action_just_pressed("dash") and not isDashing and not isAttacking:
		velocity.x = 0
		start_dash()
	if isAttacking:
		pass
	elif isDashing:
		# maintain DASH velocity
		pass

################ RUN ###########################
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
				shuriken_position.scale.x = 1
				attack.scale.x = 1
				attack.position = Vector2(10,0)
				attack_particle.scale.x = 1
				dash_particle.scale.x = 1
		elif direction < 0:
			if abs(velocity.x) > 10 and not isAttacking:
				animated_sprite_2d.flip_h = true
				collision_shape_2d.position = Vector2(-10, 0)
				kamehameha_position.scale.x = -1
				kamehameha_position.position = Vector2(-4, 2)
				shuriken_position.scale.x = -1
				attack.scale.x = -1
				attack.position = Vector2(-10,0)
				attack_particle.scale.x = -1
				dash_particle.scale.x = -1
				
		if GameManager.gravity_inverted == 1:
			animated_sprite_2d.flip_v = false
			terrain_hitbox.position = Vector2(0,4)
			attack.scale. y = 1
		elif GameManager.gravity_inverted == -1:
			animated_sprite_2d.flip_v = true
			terrain_hitbox.position =  Vector2(0,-4)
			attack.scale. y = -1
		if direction !=0:
			var target_speed := direction * SPEED
			velocity.x = move_toward(velocity.x, target_speed, SPEED * delta * 10)
		
		else:
			velocity.x = 0
####################### ANIMATIONS ############################
			if not isAttacking and is_on_floor():
				#velocity.x = move_toward(velocity.x, 0, SPEED)
				animated_sprite_2d.play("idle")
			
			elif not isAttacking && is_on_ceiling():
				animated_sprite_2d.play("idle")
		
		if direction != 0 && is_on_floor():
			animated_sprite_2d.play("run")
			
		elif velocity.y !=0 && direction == 0 && not is_on_ceiling():
			animated_sprite_2d.play("jump_vertical")
			#animated_sprite_2d.play("jump")
			
		elif velocity.y !=0 && direction !=0 && not is_on_ceiling():
			animated_sprite_2d.play("jump")
			
		
			
		elif direction != 0 && is_on_ceiling():
			animated_sprite_2d.play("run")
			
		
		else:
			animated_sprite_2d.play("idle")

############################ KAMEHAMEHA #################################
		if Input.is_action_just_pressed("shoot") and not isAttacking and GameManager.kamehameha_unlock == true and not isShooting:
			isShooting = true
			var k = kamehameha.instantiate()
			k.global_position = kamehameha_position.global_position
			k.vel = kamehameha_position.scale.x
			get_parent().add_child(k)
			await get_tree().create_timer(2).timeout
			isShooting = false

######################## SHURIKEN #############################3
		if Input.is_action_just_pressed("projectile_shoot") and not isAttacking and not isShooting:
			isShooting = true
			var s = shuriken.instantiate()
			s.global_position = shuriken_position.global_position
			s.vel = shuriken_position.scale.x
			get_parent().add_child(s)
			await get_tree().create_timer(0.5).timeout
			isShooting = false
		
	
	move_and_slide()

	
	# reset jumps
	if is_on_floor():
		jump_count = 0
	
