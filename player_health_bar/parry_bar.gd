extends Node2D

@onready var progress_bar = $ProgressBar
var parryinc = false
var wait = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("parry") && GameManager.can_parry == true:
		progress_bar.value = 0
		GameManager.can_parry = false
		await get_tree().create_timer(1.7).timeout
		parryinc = true
		await get_tree().create_timer(15).timeout
		progress_bar.value = 15
		GameManager.can_parry = true
	if parryinc == true && wait == false:
		print("increasing")
		wait = true
		progress_bar.value += 1
		await get_tree().create_timer(1).timeout
		wait = false
