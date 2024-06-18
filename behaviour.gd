extends Control

var ogpos
var hovering = false

var colour
var bname
var bdesc

var values

var parents = {}
var children = {}

var nub_scene = preload("res://nub.tscn")

var frames_prssed = 0

var ID = ""

func _reset_width():
	$Base.size.x = 192
	$BaseButton.size.x = 176
	$Nubs.size.x = 192
	
	$Nubs.position.x = 0
	$Base.position.x = 0
	$BaseButton.position.x = 8

func _change_width(change):
	$Base.size.x = $Base.size.x + change
	$BaseButton.size.x = $BaseButton.size.x + change
	$Nubs.size.x = $Nubs.size.x + change
	
	$Nubs.position.x = $Nubs.position.x - (change / 2)
	$Base.position.x = $Base.position.x - (change / 2)
	$BaseButton.position.x = $BaseButton.position.x - (change / 2)

func create_nub(name, own, owner=""):
	var nub = nub_scene.instantiate()
	nub.get_node("Nub").modulate = colour
	nub.name = name
	$Nubs.add_child(nub)
	if $Nubs.get_child_count() < 3:
		$Nubs.move_child(nub, 0)
	else:
		$Nubs.move_child(nub, $Nubs.get_child_count() - 2)
		
	if own:
		nub._set_owned(true, owner)

func remove_nub(name):
	get_node("Nubs/" + str(name)).queue_free()

func _update_behaviour(add_nub):
	if get_meta("active"):
		colour = get_meta("colour")
	else:
		colour = Color("969696")
	bname = get_meta("nickname")
	bdesc = get_meta("description")
	$Connection.default_color = colour
	$Base.modulate = colour
	$Label.text = bname
	$Description.text = bdesc
	
	_reset_width()
	var charcount = 0
	for x in bname:
		charcount = charcount + 1
		if charcount > 18:
			_change_width(8)
	for x in range(0, $Nubs.get_child_count()):
		if x < 4:
			$Nubs.add_theme_constant_override("separation", $Nubs.get_theme_constant("separation") / 2)
		else:
			_change_width(64)
			
	if not get_meta("has_nubs"):
		$Nubs.queue_free()
	elif add_nub:
		create_nub("adder", false)
		
	for x in $Nubs.get_children():
		x.get_node("Nub").modulate = colour

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_behaviour(true)
	_being_placed()

func _being_placed():
	position = get_global_mouse_position()
	position.x = position.x - (size.x / 2)
	position.y = position.y - (size.y / 2)
	var scalexy = 1.1 / BEGlobal.camera_zoom.x
	scale = Vector2(scalexy, scalexy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_behaviour(false)
	if not frames_prssed == 0:
		frames_prssed = frames_prssed + 1
		
	if get_meta("show_output") and get_meta("outputs").size() > 0:
		$Output.visible = true
	else:
		$Output.visible = false
		
	if get_meta("being_placed"):
		_being_placed()
	else:
		z_index = 0
		scale = Vector2(1, 1)
		
	if get_meta("child"):
		$Connection.clear_points()
		for y in parents:
			var x = y
			if is_instance_valid(get_parent().get_node(x)):
				var offset = -(get_parent().get_node(x).get_node("Nubs").get_node(get_meta("id")).position.x - (get_parent().get_node(x).get_node("Nubs").size.x / 2))
				$Connection.add_point(Vector2(0, 0))
				$Connection.add_point(Vector2(0, ((get_parent().get_node(x).position.y + 136) - position.y) / 2))
				$Connection.add_point(Vector2((get_parent().get_node(x).position.x - position.x) - (offset), ((get_parent().get_node(x).position.y + 136) - position.y) / 2))
				$Connection.add_point(Vector2((get_parent().get_node(x).position.x - position.x) - (offset), (get_parent().get_node(x).position.y + 136) - position.y))
				
				$Connection.add_point(Vector2((get_parent().get_node(x).position.x - position.x) - (offset), ((get_parent().get_node(x).position.y + 136) - position.y) / 2))
				$Connection.add_point(Vector2(0, ((get_parent().get_node(x).position.y + 136) - position.y) / 2))
	else:
		$Connection.clear_points()
		
func add_parent(par):
	if not parents.has(str(par)):
		set_meta("child", true)
		parents[str(par)] = ""
		get_parent().get_node(par).create_nub(get_meta("id"), true, str(self.name))
		get_parent().get_node(par).add_child_behaviour(self.get_path())
		#get_tree().get_root().get_node(BEGlobal.connector_behaviour).add_child(self.duplicate())
		#queue_free()
		
func add_child_behaviour(chi):
	if not children.has(str(chi)):
		children[str(chi)] = ""
		
func remove_child_behaviour(chi):
	children.erase(str(chi))

func _remove_parent(par, remove_nub = true):
	if is_instance_valid(get_parent().get_node(par)):
		get_parent().get_node(par).remove_child_behaviour(self.get_path())
		if remove_nub:
			get_parent().get_node(par).remove_nub(get_meta("id"))
		parents.erase(str(par))
	
func _move(pos):
	position = position + (pos / parents.size())
	for x in children:
		get_tree().get_root().get_node(x)._move(pos)
		
func _unlink():
	for x in range(0, parents.size()):
		for y in parents:
			_remove_parent(y)
		
func _input(event):
	if event is InputEventMouseMotion and $BaseButton.button_pressed and frames_prssed > 2:
		position = position + event.relative / BEGlobal.camera_zoom
		for x in children:
			get_tree().get_root().get_node(x)._move(event.relative / BEGlobal.camera_zoom)
	if event is InputEventMouseButton:
		if event.button_index == 1 and not event.pressed and hovering and BEGlobal.connecting_behaviour and not get_parent().get_node(BEGlobal.connector_behaviour) == self and not parents.has(BEGlobal.connector_behaviour):
			add_parent(BEGlobal.connector_behaviour)
   
func _on_base_button_mouse_entered():
	BEGlobal.hovering_behaviour = true
	BEGlobal.hovering_over_behaviour = self.get_path()
	hovering = true

func _on_base_button_mouse_exited():
	BEGlobal.hovering_behaviour = false
	hovering = false

func _on_base_button_button_down():
	frames_prssed = 1

func _on_base_button_button_up():
	if frames_prssed < 11:
		get_tree().get_root().get_node("BehaviourEditor")._open_behaviour_menu(self.get_path())
	frames_prssed = 0
	
func _delete():
	_unlink()
	for x in children:
		get_tree().get_root().get_node(x)._remove_parent(str(self.name))
	queue_free()

func _set_values(v):
	values = v
	
func _get_value(value):
	return values[value]

func _get_values():
	return values
	
func _edit_value(v, e, n):
	self.get_meta("values")[v][e] = n
	print(self.name + " KEHGFHEDSFJKGHSEFDBHGFT")

func _get_info():
	return {
		"parents": parents,
		"children": children,
	}

func _on_output_botton_button_down():
	pass # Replace with function body.
