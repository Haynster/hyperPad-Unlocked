extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_toggle_button_down():
	if get_parent().get_meta("toggled"):
		get_parent().set_meta("toggled", false)
		$AnimationPlayer.play("toggle")
	else:
		get_parent().set_meta("toggled", true)
		$AnimationPlayer.play_backwards("toggle")


func _set_state(s):
	if s:
		$AnimationPlayer.play("toggle")
		$AnimationPlayer.stop()
	else:
		$AnimationPlayer.play("toggle")
		$AnimationPlayer.seek(1)


func _on_animation_player_animation_finished(anim_name):
	get_tree().get_root().get_node("BehaviourEditor")._edit_behaviour_value(get_parent().get_meta("value"), get_parent().get_meta("toggled"), "Toggled")
