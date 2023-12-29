extends CharacterBody2D

@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 400
@export var jump_force : float = 600
@export var max_jump_count : int = 2
var jump_count : int = 0

@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
@export var double_jump : = false

var is_grounded : bool = false
var jump_velocity: float = -400
var speed: float = 300
var is_attacking: bool = false
var can_attack: bool = true
var parrying: bool = false
var can_parry: bool = true
var player_pos: Vector2 = Vector2.ZERO

@onready var player_sprite = $AnimatedSprite2D
@onready var knife_cooldown = $"knife/knife cooldown"
@onready var knife_hitbox = $knife/Area2D/CollisionShape2D
@onready var parry_hitbox = $"parry hitbox/CollisionShape2D"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	add_to_group("Player")
	$knife/Area2D/CollisionShape2D.disabled = true
	$"parry hitbox/CollisionShape2D".disabled = true


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor() and jump_count != 0:
		jump_count = 0

	# Handle Jump.
	if jump_count < max_jump_count:
		if Input.is_action_just_pressed("Jump"):
			velocity.y = jump_velocity
			jump_count += 1
			print(jump_count)
	
			
	#handles wall slide.
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()

# --------- VARIABLES ---------- #



# --------- BUILT-IN FUNCTIONS ---------- #

func _process(_delta):
	player_pos = $".".position
	GameManager.player_pos = player_pos
	print(GameManager.player_pos)
	# Calling functions
	player_animations()
	flip_player()
	parry()
	death()
	if can_attack == true:
		if Input.is_action_just_pressed("attack"):
			can_attack = false
			attacking()
			await get_tree().create_timer(0.4).timeout
			$knife/Area2D/CollisionShape2D.disabled = false
# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->

# Handle Player Animations
func player_animations():
	if Input.is_action_just_pressed("Jump"):
		player_sprite.play("Idle")
	if is_attacking == true:
		player_sprite.play("Attack")
		var direction = Input.get_axis("move_left", "move_right")
		if direction >= 0:
			player_sprite.offset.x = 35
			knife_hitbox.position.x = 296
		elif direction < 0:
			player_sprite.offset.x = -35
			knife_hitbox.position.x = 220
		await get_tree().create_timer(0.5).timeout
		player_sprite.offset.x = 0
	if parrying == true:
		player_sprite.play("parry")
		var direction = Input.get_axis("move_left", "move_right")
		if direction >= 0:
			player_sprite.offset.x = 35
		elif direction < 0:
			player_sprite.offset.x = -35
		await get_tree().create_timer(0.8).timeout
		player_sprite.offset.x = 0
	if is_on_floor():
		if abs(velocity.x) > 0:
			player_sprite.play("Move", 1.5)
		else:
			player_sprite.play("Idle")
	if Input.is_action_just_pressed("parry") && can_parry == true:
		player_sprite.play("parry")
	
		

# Flip player sprite based on X velocity
func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
	elif velocity.x >= 0:
		player_sprite.flip_h = false

func attacking():
	is_attacking = true
	knife_cooldown.start()


func _on_knife_cooldown_timeout():
	is_attacking = false
	can_attack = true
	$knife/Area2D/CollisionShape2D.disabled = true

func parry():
	if Input.is_action_just_pressed("parry") && can_parry == true:
		parrying = true
		$"parry hitbox/CollisionShape2D".disabled = false
		can_parry = false
		await get_tree().create_timer(1.7).timeout
		parrying = false
		$"parry hitbox/CollisionShape2D".disabled = true
		await get_tree().create_timer(14).timeout
		can_parry = true
		
func health_loss():
	GameManager.health -= 1

func death():
	if GameManager.health <= 0:
		if GameManager.is_tutorial:
			GameManager.load_tutorial()
			GameManager.health = 3
		else:
			pass
