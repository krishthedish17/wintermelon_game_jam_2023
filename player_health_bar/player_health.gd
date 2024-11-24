extends Node2D

@onready var progress_bar = $parry_bar/ProgressBar
var parryinc = false
var wait = false

@onready var full = $full
@onready var two = $"2"
@onready var one = $"1"

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.can_parry = true
	print(GameManager.can_parry)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("parry") && GameManager.can_parry == true:
		print("parry bar is detected")
		progress_bar.value = 0
		print("value" + str(progress_bar.value))
		GameManager.can_parry = false
		await get_tree().create_timer(1.7).timeout
		parryinc = true
		await get_tree().create_timer(8.2).timeout
		progress_bar.value = 100
		parryinc = false
		GameManager.can_parry = true
	if parryinc == true && wait == false:
		print(progress_bar.value)
		wait = true
		progress_bar.value += 10
		await get_tree().create_timer(1).timeout
		wait = false

	if GameManager.health >= 3:
		full.visible = true
	elif GameManager.health == 2:
		two.visible = true
		full.visible = false
	elif GameManager.health == 1:
		one.visible = true
		two.visible = false
	else:
		one.visible = false
	
