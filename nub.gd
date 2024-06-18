extends Control

var create_line
var line_pos

var owned = false
var owner_behaviour

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not create_line:
		$Line2D.clear_points()

func _input(event):
	if event is InputEventMouseMotion and create_line:
		$Line2D.add_point(line_pos + event.relative / BEGlobal.camera_zoom)
		line_pos = line_pos + event.relative / BEGlobal.camera_zoom

func _on_button_button_down():
	if name == "adder":
		BEGlobal.reconnecting_behaviour = false
		BEGlobal.connecting_behaviour = true
		BEGlobal.connector_behaviour = get_parent().get_parent().get_path()
		$Line2D.add_point(Vector2(0, 0))
		line_pos = Vector2(0, 0)
		create_line = true
	else:
		BEGlobal.connected_nub_owner = owner_behaviour
		BEGlobal.reconnecting_behaviour = true
		BEGlobal.connecting_behaviour = true
		BEGlobal.connector_behaviour = get_parent().get_parent().get_path()
		$Line2D.add_point(Vector2(0, 0))
		line_pos = Vector2(0, 0)
		create_line = true

func _on_button_button_up():
	BEGlobal.connecting_behaviour = false
	create_line = false

func _set_owned(bool, owner_b):
	owner_behaviour = owner_b
	owned = bool
