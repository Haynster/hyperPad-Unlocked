extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_text_submitted(new_text):
	get_tree().get_root().get_node("BehaviourEditor")._edit_behaviour_value(get_meta("value"), new_text, get_meta("input"))


func _on_clear_button_down():
	$Input.text = ""
	get_tree().get_root().get_node("BehaviourEditor")._edit_behaviour_value(get_meta("value"), "", get_meta("input"))
