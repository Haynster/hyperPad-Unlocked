extends Control

signal selected_changed(new)

var elements = ["china", "fir", "s", "fart"]
var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = get_meta("selected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	if not open:
		open = true
		elements = get_meta("elements")
		_open_menu()

func _open_menu():
	var index = 0
	var origin = Vector2(0, 0)
	var offset = 0
	for x in elements:
		var type
		if index == 0:
			type = "top"
		elif index == elements.size() - 1:
			type = "down"
		else:
			type = "middle"
			
		var element = load("res://behaviour_editor_input_scenes/dropdown_elements/" + type + ".tscn").instantiate()
		element.text = x
		element.position = Vector2(origin.x, origin.y + offset)
		$Elements.add_child(element)
		offset = offset + 24
		index = index + 1
	$AnimationPlayer.stop()
	$AnimationPlayer.play("open_close")

func _choice(chose):
	$AnimationPlayer.stop()
	$AnimationPlayer.play_backwards("open_close")
	$AnimationPlayer.seek(0.2)
	for x in $Elements.get_children():
		x.queue_free()
		
	$Label.text = chose
	set_meta("selected", chose)
	open = false
	if is_instance_valid(get_tree().get_root().get_node("BehaviourEditor")):
		get_tree().get_root().get_node("BehaviourEditor")._edit_behaviour_value(get_meta("value"), chose, "Selected")
		get_tree().get_root().get_node("BehaviourEditor")._open_behaviour_menu("", true)
	selected_changed.emit(chose)
	
