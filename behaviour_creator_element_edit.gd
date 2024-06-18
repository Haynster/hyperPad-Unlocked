extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = get_meta("Title")

func _on_line_edit_text_changed(new_text):
	if is_instance_valid(get_tree().get_root().get_node("BehaviourCreator")):
		if new_text == "true":
			get_tree().get_root().get_node("BehaviourCreator").element_changed(true, self)
		elif new_text == "false":
			get_tree().get_root().get_node("BehaviourCreator").element_changed(false, self)
		else:
			get_tree().get_root().get_node("BehaviourCreator").element_changed(new_text, self)
