extends Node2D

@onready var sprite = $CharacterBody2D/AnimatedSprite2D
@onready var animation_player = $"../AnimationPlayer"
@onready var texture_rect = $TextureRect
@onready var hit_player = $"hit player"
@onready var collision_shape_2d = $CharacterBody2D/CollisionShape2D
@onready var area_2d = $CharacterBody2D/Area2D

var health = 100
var boss_attack = RandomNumberGenerator.new()
var current_attack = 0
var ball_charge = false
var smoke = false
var fiend = false
var can_attack = true
var berry_shot = true
var hit = false
var invuln = false
var started_laser = false
var losing_health = false
var dead = false
var started_fight = false
var original_pos = position.x
var forward = false
var is_ball = false
# Called when the node enters the scene tree for the first time.
func _ready():
	health = 100
	GameManager.is_tutorial = false
	GameManager.health = 3
	dead = false
	#texture_rect.visible = false
	sprite.play("dead")
	await get_tree().create_timer(2.1).timeout
	started_fight = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead == false && started_fight == true:
		attack()
		taking_damage()
		health_loss()
	death()
	GameManager.fire_health = health
	if GameManager.health == 0:
		started_fight = false
	if is_ball:
		collision_shape_2d.disabled = true
	else:
		collision_shape_2d.disabled = false

func attack():
	if can_attack == true:
		var current_attack = boss_attack.randi_range(1, 5)
		if GameManager.is_berry_shot:
			current_attack = boss_attack.randi_range(2, 4)
		if is_ball:
			while current_attack == 2:
				current_attack = boss_attack.randi_range(1, 5)
		if GameManager.wave_shot:
			while current_attack == 3:
				current_attack = boss_attack.randi_range(1, 5)
		if GameManager.is_smoke:
			while current_attack == 4:
				current_attack = boss_attack.randi_range(1, 5)
		can_attack = false
		print("attack picked")
		if (current_attack == 1 || current_attack == 5) && (GameManager.is_berry_shot == false):
			berry_shot = true
			await get_tree().create_timer(1.7).timeout
			GameManager.berry_shot = true
			await get_tree().create_timer(2.4).timeout
		if current_attack == 2 && is_ball == false:
			ball_charge = true
			is_ball = true
			await get_tree().create_timer(1.2).timeout
			forward = true
			ball()
			await get_tree().create_timer(11).timeout
			is_ball = false
		"
		if current_attack == 3 && GameManager.wave_shot == false:
			fiend = true
			await get_tree().create_timer(0.3).timeout
			GameManager.pepper_fiend = true
		if current_attack == 4 && GameManager.is_smoke == false:
			smoke = true
			await get_tree().create_timer(0.5).timeout
			GameManager.pepper_smoke = true
		"
		current_attack = 0
		await get_tree().create_timer(1.5).timeout
		can_attack = true


func _on_area_2d_area_entered(area):
	if area.is_in_group("knife"):
		if hit == false && invuln == false:
			print("hit")
			await get_tree().create_timer(0.1).timeout
			hit = true
			GameManager.fire_hit = true
			invuln = true
func taking_damage():
	if hit == true || GameManager.parry_hit == true:
		print("playing anim")	
		hit_player.play("hit")
		losing_health = true
		GameManager.berry_shot = true
		await get_tree().create_timer(0.8).timeout
		invuln = false
		hit = false
		GameManager.fire_hit = false
		GameManager.parry_hit = false
	elif ball_charge == false && fiend == false && hit == false && smoke == false && berry_shot == false && dead == false:
		sprite.play("Idle")
	if ball_charge == true && dead == false:
		sprite.play("fire")
		await get_tree().create_timer(4.2).timeout
		ball_charge = false
	if fiend == true && dead == false:
		sprite.play("pan flip")
		await get_tree().create_timer(0.6).timeout
		fiend = false
	if smoke == true && dead == false:
		sprite.play("smoke")
		await get_tree().create_timer(1).timeout
		smoke = false
	if berry_shot == true && dead == false:
		sprite.play("pepper shot")
		await get_tree().create_timer(2.4).timeout
		berry_shot = false

func health_loss():
	if losing_health == true:
		losing_health = false
		for i in range(10):
			health -= 0.02083333333
			print("health" + str(health))
			await get_tree().create_timer(0.2).timeout
	
func death():
	if health <= 0:
		dead = true
		sprite.play("dead")
		texture_rect.visible = true
		GameManager.beat_fire = true
		animation_player.play("win")
		await get_tree().create_timer(5).timeout
		GameManager.load_select_screen()
		queue_free()

func ball():
	while position.x > -600 && forward == true:
		position.x -= 20
		await get_tree().create_timer(0.1).timeout
	forward = false
	if forward == false && is_ball:
		while position.x < original_pos:
			position.x += 20
			await get_tree().create_timer(0.1).timeout
	
	




func _on_area_2d_body_entered(body):
	if is_ball:
		if body.is_in_group("player"):
			print("bro got shot rip")
			body.health_loss()
