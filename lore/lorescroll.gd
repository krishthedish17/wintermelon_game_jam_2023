extends ParallaxBackground

var stop = false
@onready var button = $"../Button"

# Called when the node enters the scene tree for the first time.
func _ready():
	stop = false
	button.text = "Skip?"
	await get_tree().create_timer(38).timeout
	stop = true
	button.text = "Next"
	$"../Button".grab_focus()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stop == false:
		scroll_offset.y -= 40 * delta
	
