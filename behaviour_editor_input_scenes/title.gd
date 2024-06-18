extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = get_meta("title")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = get_meta("title")
