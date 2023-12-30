extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GameManager.won = true


func _on_pressed():
	GameManager.won = true
	print(GameManager.won)
	GameManager.load_select_screen()
	
