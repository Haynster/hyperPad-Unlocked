extends Control

var frames_prssed = 0

# make it sahow the  ehbahviour when you drag it into editor

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not frames_prssed == 0:
		frames_prssed = frames_prssed + 1
	if frames_prssed > 8:
		frames_prssed = 0
		BEGlobal.grabbing_behaviour = true
		BEGlobal.grabbed_behaviour = $Label.text
		BEGlobal.grabbed_behaviour_colour = $BG.modulate


func _on_button_button_down():
	frames_prssed = 1

func _on_button_button_up():
	frames_prssed = 0
	if frames_prssed < 9:
		pass
