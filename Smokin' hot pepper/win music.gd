extends AudioStreamPlayer

var played_sound = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.dying_boss == true:
		if played_sound == false:
			played_sound = true
			playing = true

