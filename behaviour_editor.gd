extends Control

var selected_catergory = "Interaction"
var selected_catergory_colour = ""
var catergory_colours = {"Interaction": Color(0.5137, 0.4588, 0.6471, 1), "Object": Color(0.9647, 0.5059, 0.5216, 1), "Screen": Color(0.8902, 0.7333, 0.4275, 1), "Transform": Color(0.3804, 0.6275, 0.6706, 1), "UI": Color(0.4941, 0.3843, 0.4588, 1), "FX": Color(0.8314, 0.3922, 0.3176, 1), "Scene": Color(0.3216, 0.7529, 0.7137, 1), "Physics": Color(0.6863, 0.4784, 0.3725, 1), "Logic": Color(0.4196, 0.6235, 0.4314, 1), "Custom": Color(0.3137, 0.4314, 0.5882, 1)}

var moving_cam
var can_move_cam
var ogcampos

var mouse_location

var placing_behaviour 
var placed_behaviour
var can_place_behaviour = true

var object_editing

var behaviours_compiled = []

var behaviour_list_open = true
var behaviour_edit_menu_open = false
var editing_behaviour

var prefab_behaviours = { "A5F9C972-DD90-48B5-AE78-A69FC6FBF978" : { "groups" : [ ], "alias" : "Jump with Button", "active" : true, "root" : true, "position" : [ 588.5, 422.5 ], "collapsed" : false, "outputs" : [ ], "inputFields" : { "playsAnimation" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "1" }, "objectA" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "AC1D58B9-1B27-43A8-9CE4-00A4EC3ABC36" }, "shouldAutoFlip" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "1" }, "minPower" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "15" }, "value" : "objectB_ID", "shouldWallJump" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "0" }, "alias" : "Jump with Button", "objectB" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "self" }, "behaviourCategory" : "Interaction", "storage" : [ ], "disableRotation" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "1" }, "jumps" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "1" }, "BehaviourCustomAttributeAnimationPriority" : { "fieldType" : "Value", "controlledBy" : "self" } }, "behaviorName" : "Jump With Button" }, "3D047EF1-D294-4741-A87F-2832E1126B1F" : { "groups" : [ ], "alias" : "Joystick Controlled", "active" : true, "root" : true, "position" : [ 821.60771159578121, 421.45621942203383 ], "collapsed" : false, "outputs" : [ ], "inputFields" : { "values" : [ "x", "y", "angle", "objectB_ID" ], "move" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "1" }, "objectB" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "self" }, "up" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "0" }, "analog" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "0" }, "storage" : [ ], "disableRotation" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "1" }, "invertX" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "0" }, "right" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "1" }, "speed" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "12" }, "shouldFlip" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "1" }, "BehaviourCustomAttributeAnimationPriority" : { "fieldType" : "Value", "controlledBy" : "self" }, "invertY" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "0" }, "alias" : "Joystick Controlled", "behaviourCategory" : "Interaction", "down" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "0" }, "rotate" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "0" }, "left" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "1" }, "decellerationRate" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "100" }, "airSpeed" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "12" }, "accellerationRate" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "100" }, "objectA" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "CE49D3D6-14B3-4E25-A6B1-E608C60DEC32" }, "playsAnimation" : { "fieldType" : "Value", "controlledBy" : "self", "value" : "1" } }, "behaviorName" : "Joystick Controlled" }, "EB58E606-B1A2-49FC-B6F4-155C3F67EDB5" : { "groups" : [ ], "alias" : "Comment", "active" : true, "root" : true, "position" : [ 672.5, 224 ], "collapsed" : false, "outputs" : [ ], "inputFields" : { "value" : "this is a prefab object!", "behaviourCategory" : "Custom", "alias" : "Comment" }, "behaviorName" : "Comment v1.26" } }

var behaviours_list = {
	"Interaction": {"Controls": ["Drag & Drop", "Jump with Button", "Shoot with Button"], "Joystick": ["Joystick Controlled", "Joystick Input"], "Keyboard": ["Keyboard Event", "Keyboard Shortcut"], "Mouse": ["Get Mouse Position", "Mouse Event", "Set Cursor Style"], "Tilt": ["Tilt Controlled", "Tilt Sensor"], "Touching": ["Dragged Finger", "Started Touching", "Stopped Touching", "Swipe Gesture", "While Touching"]},
	"Object": {"Attributes": ["Get Attribute", "Get Object", "Modify Tags", "Set Attribute"], "Collision Detection": ["Collision Event", "Create Collision", "Hit Point Test", "Raycast Test"], "Game Play": ["Hit by Bullet", "Ignore Bullets", "Passable Platform", "Shoot"], "Graphics": ["Draw", "Get Noise Value", "Get Pixel", "Noise Map", "Render Texture"], "Lifetime": ["Destroy Object", "Disable Object", "Enable Object", "Spawn Object"], "Movement": ["Jump", "Moveable Platform", "Patrol"]},
	"Screen": {"Collision Detection": ["Hit Screen Edge"], "Effects": ["Rotate Screen By", "Set Screen Rotation", "Shake Screen", "Zoom Screen"], "Game Play": ["Conforms to Screen", "Wrap Around Screen"], "Movement": ["Get Screen", "Move Screen", "Screen Follow", "Screen to Object", "Screen to Point"]},
	"Transform": {"Anchor": ["Set Anchor Point"], "Appearance": ["Get Color", "Set Blending Mode", "Set Color", "Set Graphic", "Set Visibility"], "Flip": ["Get Graphic Flip", "Set Graphic Flip"], "Layer": ["Get Z Order", "Move by", "Move to Object", "Move to Point"], "Rotate": ["Get Rotation", "Lock Rotation", "Rotate By", "Rotate to Angle", "Rotate to Object"], "Scale": ["Get Scale", "Scale by", "Scale to"], "Skew": ["Get Skew", "Skew by", "Skew to"]},
	"UI": {"Device": ["Battery Status", "Device Identifier"], "Indicator": ["Get Health Bar", "Get Life Indicator", "Indicator Event", "Set Health Bar", "Set Life Indicator"], "Label": ["Add to Score", "Count Down", "Edit Text Event", "Edit Text Field", "Get Label", "Set Label"], "Pop Up": ["Alert", "Text Bubble"]},
	"FX": {"Animation": ["Play Animation", "Set Animation State"], "Sound Effects": ["Play Sound", "Set Sound Settings", "Stop All Sound Effects"], "Visual Effects": ["Start Particles", "Start Trail", "Stop Visual Effects"]},
	"Scene": {"Advertisement": ["Ad Clicked", "Trigger Ad"], "Background": ["Get Background", "Set Background"], "Layers": ["Set Layer Visibility"], "Music": ["Get Music Settings", "Pause Music", "Play Music", "Set Music Settings", "Stop Music"], "Overlay": ["Close Overlay", "Load Overlay"], "Scene": ["Load Scene", "Preload Scene", "Quit Project", "Unload Scene"], "Time": ["Set Time Scale"]},
	"Physics": {"Attachments": ["Detach Object", "Pivot Attach", "Rope Attach", "Spring Attach", "Weld Attach"], "Events": ["Active State", "Falling State", "Moving State"], "Forces": ["Apply Force", "Apply Torque", "Get Gravity", "Propel Object", "Set Gravity"], "Mode": ["Set Physics Mode"], "Properties": ["Get Physics Properties", "Ignore Collisions", "Set Physics Property"], "Velocity": ["Get Rotational Velocity", "Get Velocity", "Set Rotational Velocity", "Set Velocity"]},
	"Logic": {"Arithmetic": ["Add Values", "Divide Values", "Math Expression", "Modulus", "Multiply Values", "Square Root", "Subtract Values"], "Array": ["Get Array Count", "Sort Array"], "Conditional": ["Execute Sequence", "If", "Loop"], "Functions": ["Bitwise Operation", "Boolean", "Clamp Value", "Lerp Function", "Math Function", "Maximum", "Minimum", "Random Number", "Random Seed", "Round Number"], "Misc.": ["Calculate Direction", "Calculate Distance", "Get Bounding Box", "Get Time", "Is Intersecting", "Sort by Distance"], "Text": ["Combine Text", "Text Length", "Text Operation", "Trim Text"]},
	"Custom": {"Behaviors": ["Behavior Bundle", "Comment", "Frame Event", "Set Behavior State", "Track Event"], "Broadcast": ["Broadcast Message", "Receive Message"], "Networking": ["Authenticate OAuth", "Connect To Socket", "Emit To Socket", "Get OAuth Credentials", "Get Socket Status", "HTTP Request", "Load Image", "Open URL", "Remove OAuth Credentials", "Socket Event", "Socket.io Client"], "Permanent Storage": ["Load from File", "Modify Save File"], "Social": ["Share"], "Storage": ["Array", "Box Container", "Clipboard", "Dictionary", "Get Array Value", "Get Dictionary Value", "Modify Array", "Modify Dictionary", "Value"], "Timers": ["Timer", "Wait"]}
}

var behaviour_inputs = {}

var behaviour_nums = {}
var behaviour_nicks = {}

func _load_mods():
	var mods_path = "mods/"
	var mods_folder = DirAccess.open(mods_path)
	var mods = []
	if mods_folder:
		mods_folder.list_dir_begin()
		var file_name = mods_folder.get_next()
		while file_name != "":
			if mods_folder.current_is_dir():
				mods.append(file_name)
			file_name = mods_folder.get_next()
	# behaviours need to get input form mods soemthing
	for a in mods:
		var behaviourinputspath = mods_path + a + "/behaviour_jsons/"
		var behaviourjsonfile = FileAccess.open(mods_path + a + "/behaviours.json", FileAccess.READ)
		var behaviours = {}
		if behaviourjsonfile:
			behaviours = str_to_var(behaviourjsonfile.get_as_text())
		for x in behaviours:
			if not behaviours_list.has(x):
				behaviours_list[x] = {}
			for y in behaviours[x]:
				if not behaviours_list[x].has(y):
					behaviours_list[x][y] = []
				for z in behaviours[x][y]:
					behaviours_list[x][y].append(z)
		add_inputs_from_folder(behaviourinputspath)

func add_inputs_from_folder(behaviourinputspath):
	var folder_load = DirAccess.open(behaviourinputspath)
	folder_load.list_dir_begin()
	var file_name = folder_load.get_next()
	while file_name != "":
		if not folder_load.current_is_dir():
			var behaviourjsonfile = FileAccess.open(behaviourinputspath + file_name, FileAccess.READ)
			var behaviours = str_to_var(behaviourjsonfile.get_as_text())
			behaviour_inputs[file_name.left(file_name.length() - 5)] = behaviours
		file_name = folder_load.get_next()

func _compile():
	for x in $Node2D/Behaviours.get_children():
		var binfo = x._get_info()
		var data = {
			"XPOS": x.position.x,
			"YPOS": x.position.y,
			"NAME": x.get_meta("name"),
			"ALIAS": x.get_meta("nickname"),
			"TAG": x.get_meta("id"),
			"PARENTS": binfo["parents"],
			"CHILDREN": binfo["children"],
			"CATERGORY": x.get_meta("catergory"),
			"VALUES": x.get_meta("values"),
			"OUTPUTS": x.get_meta("outputs"),
			"DESCRIPTION": x.get_meta("description"),
			"ACTIVE": x.get_meta("active")
		}
		behaviours_compiled.append(data)
	return behaviours_compiled

# Called when the node enters the scene tree for the first time.
func _ready():
	add_inputs_from_folder("behaviour_jsons/")
	_load_mods()
	selected_catergory = "Interaction"
	_create_behaviour_list()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_viewport().get_mouse_position().x < $UI/BehaviourList.size.x:
		can_move_cam = false
		mouse_location = "blist"
	elif get_viewport().get_mouse_position().x > get_viewport().size.x - $UI/BehaviourEdit/BG/Panel.size.x:
		mouse_location = "bmenu"
		can_move_cam = false
		
	BEGlobal.camera_zoom = $Node2D/Camera2D.zoom
	
	if BEGlobal.grabbing_behaviour:
		BEGlobal.grabbing_behaviour = false
		placing_behaviour = true
		placed_behaviour = spawn_behaviour(BEGlobal.grabbed_behaviour, "Node2D/Behaviours", selected_catergory)
	
	for x in get_node("UI/ToolBar/Buttons").get_children():
		if not x.name == selected_catergory:
			x.modulate = Color("ffffff58")
		else:
			x.modulate = Color("ffffff")
	
	if Input.is_action_just_released("debug"):
		$UI/Loading.set_meta("text", "Loading Debug...")
		$UI/Loading.visible = true
		await get_tree().create_timer(0.5).timeout
		$UI/Loading.visible = false
		get_tree().change_scene_to_packed(BEGlobal.behaviour_creator_scene)

var behaviour_scene = preload("res://behaviour.tscn")
var IDcharacters = 'abcdefghijklmnopqrstuvwxyz'

func spawn_behaviour(behaviour, at, catergory, transfer_properties = false, aliasP = "", positionP = Vector2(0, 0)):
	var behaviour_instance = behaviour_scene.instantiate()
	behaviour_instance.set_meta("name", behaviour)
	behaviour_instance.set_meta("catergory", catergory)
	var original_name = behaviour
	var alias = ""
	
	if behaviour_nums.has(original_name):
		behaviour_instance.set_meta("nickname", original_name + str(behaviour_nums[original_name]))
		alias = original_name + str(behaviour_nums[original_name])
		behaviour_nicks[original_name + str(behaviour_nums[original_name])] = ""
		behaviour_nums[original_name] = behaviour_nums[original_name] + 1
	else:
		behaviour_nums[original_name] = 1
		behaviour_nicks[original_name] = ""
		behaviour_instance.set_meta("nickname", original_name)
		alias = original_name
	behaviour_instance.name = alias
	
	if not aliasP == "":
		behaviour_instance.set_meta("nickname", aliasP)
		behaviour_instance.name = aliasP
	var ID = ""
	for x in range(0, 31):
		ID = ID + IDcharacters[randi_range(0, 25)]
	behaviour_instance.set_meta("id", str(ID))
	
	if behaviour_inputs.has(behaviour):
		if behaviour_inputs[behaviour].has("inputs"):
			behaviour_instance.set_meta("values", behaviour_inputs[behaviour]["inputs"])
		if behaviour_inputs[behaviour].has("outputs"):
			behaviour_instance.set_meta("outputs", behaviour_inputs[behaviour]["outputs"])
		if behaviour_inputs[behaviour].has("description"):
			behaviour_instance.set_meta("description", behaviour_inputs[behaviour]["description"])
	if transfer_properties:
		behaviour_instance.set_meta("being_placed", false)
		behaviour_instance.set_meta("colour", get_node(editing_behaviour).get_meta("colour"))
		behaviour_instance.set_meta("values", get_node(editing_behaviour).get_meta("values"))
		behaviour_instance.set_meta("outputs", get_node(editing_behaviour).get_meta("outputs"))
		behaviour_instance.set_meta("active", get_node(editing_behaviour).get_meta("active"))
		behaviour_instance.position = Vector2(get_node(editing_behaviour).position.x + 192, get_node(editing_behaviour).position.y)
	else:
		if not positionP == Vector2(0, 0):
			behaviour_instance.position = positionP
			behaviour_instance.set_meta("colour", Color(catergory_colours[catergory]))
			behaviour_instance.set_meta("being_placed", false)
		else:
			behaviour_instance.position = get_global_mouse_position()
			behaviour_instance.set_meta("colour", BEGlobal.grabbed_behaviour_colour)
			
	get_node(at).add_child(behaviour_instance)
	return behaviour_instance
	
func load_prefab_behaviours(b):
	for x in b:
		spawn_behaviour(b[x]["behaviorName"], "Node2D/Behaviours", b[x]["inputFields"]["behaviourCategory"], false, b[x]["inputFields"]["alias"], Vector2(b[x]["position"][0], b[x]["position"][1]))
		for y in b[x]:
			pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if not event.pressed and placing_behaviour and is_instance_valid(placed_behaviour):
				if can_place_behaviour and mouse_location == "":
					placed_behaviour.set_meta("being_placed", false)
					placed_behaviour = null
				else:
					placed_behaviour.queue_free()
			if not event.pressed and BEGlobal.hovering_behaviour and BEGlobal.reconnecting_behaviour:
				BEGlobal.reconnecting_behaviour = false
				get_node("Node2D/Behaviours").get_node(str(BEGlobal.connected_nub_owner))._remove_parent(str(BEGlobal.connector_behaviour))
			
			if event.pressed:
				if mouse_location == "BG":
					_close_behaviour_menu()
					_open_behaviour_list()
				
		if event.button_index == 3:
			moving_cam = event.pressed
		
		if can_move_cam:
			if event.button_index == 4:
				$Node2D/Camera2D.zoom = $Node2D/Camera2D.zoom + Vector2(0.1, 0.1)
			if event.button_index == 5:
				$Node2D/Camera2D.zoom = $Node2D/Camera2D.zoom + Vector2(-0.1, -0.1)
		else:
			if mouse_location == "blist":
				if event.button_index == 4 and $UI/BehaviourList/Elements.position.y < 0:
					$UI/BehaviourList/Elements.position.y = $UI/BehaviourList/Elements.position.y + 15
				if event.button_index == 5 and $UI/BehaviourList/Elements.position.y > -list_element_offset:
					$UI/BehaviourList/Elements.position.y = $UI/BehaviourList/Elements.position.y - 15
			if mouse_location == "bmenu":
				if event.button_index == 4 and $UI/BehaviourEdit/Inputs.position.y < 112:
					$UI/BehaviourEdit/Inputs.position.y = $UI/BehaviourEdit/Inputs.position.y + 15
				if event.button_index == 5 and $UI/BehaviourEdit/Inputs.position.y > -inputs_element_offset + (112 + $UI/BehaviourEdit/BG/BG3.size.y):
					$UI/BehaviourEdit/Inputs.position.y = $UI/BehaviourEdit/Inputs.position.y - 15
	if event is InputEventMouseMotion and moving_cam:
		$Node2D/Camera2D.position = $Node2D/Camera2D.position - event.relative / BEGlobal.camera_zoom

func _check_for_behaviour_json(path, behaviour):
	var file = FileAccess.open(path + behaviour + ".json", FileAccess.READ)
	if file:
		var content = str_to_var(file.get_as_text())
		return content

func _on_interaction_button_down():
	selected_catergory = "Interaction"
	_create_behaviour_list()

func _on_object_button_down():
	selected_catergory = "Object"
	_create_behaviour_list()

func _on_screen_button_down():
	selected_catergory = "Screen"
	_create_behaviour_list()

func _on_transform_button_down():
	selected_catergory = "Transform"
	_create_behaviour_list()

func _on_ui_button_down():
	selected_catergory = "UI"
	_create_behaviour_list()

func _on_fx_button_down():
	selected_catergory = "FX"
	_create_behaviour_list()

func _on_scene_button_down():
	selected_catergory = "Scene"
	_create_behaviour_list()

func _on_physics_button_down():
	selected_catergory = "Physics"
	_create_behaviour_list()

func _on_logic_button_down():
	selected_catergory = "Logic"
	_create_behaviour_list()

func _on_custom_button_down():
	selected_catergory = "Custom"
	_create_behaviour_list()

func _on_name_text_submitted(new_text):
	if behaviour_nicks.has(new_text):
		OS.alert("Choose a name that isnt in your game already.", "Name already exists!")
	else:
		behaviour_nicks[new_text] = ""
		get_node(editing_behaviour).set_meta("nickname", new_text)

func _open_behaviour_menu(behaviour, reload = false):
	_close_behaviour_list()
	if not reload:
		editing_behaviour = behaviour
	if not behaviour_edit_menu_open:
		$UI/BehaviourEdit.visible = true
		behaviour_edit_menu_open = true
	if is_instance_valid(get_node(editing_behaviour)):
		$UI/BehaviourEdit/Name.text = get_node(editing_behaviour).get_meta("nickname")
		$UI/BehaviourEdit/Type.text = "(" + get_node(editing_behaviour).get_meta("name") + ")"
		_behaviour_on_off(get_node(editing_behaviour).get_meta("active"))
		_create_behaviour_inputs(get_node(editing_behaviour).get_meta("values"))
	
	for y in $Node2D/Behaviours.get_children():
		y.set_meta("show_output", true)

func _close_behaviour_menu():
	behaviour_edit_menu_open = false
	$UI/BehaviourEdit.visible = false
	editing_behaviour = null
	
	for y in $Node2D/Behaviours.get_children():
		y.set_meta("show_output", false)
	
func _delete_behaviour_inputs():
	for x in $UI/BehaviourEdit/Inputs.get_children():
		x.queue_free()
		
var inputs_element_offset = 0

func _create_behaviour_inputs(values):
	var offset = 0
	var origin = Vector2(8, 8)
	var value = 0
	var selected = ""
	_delete_behaviour_inputs()
	if values:
		for x in values:
			var original_offset = offset
			var value_instance = load("res://behaviour_editor_input_scenes/" + str(x["Type"]) + ".tscn").instantiate()
			value_instance.position = Vector2(origin.x, origin.y + offset)
			value_instance.set_meta("value", value)
			if x["Type"] == "title":
				value_instance.set_meta("title", x["Title"] + ":")
				offset = offset + 20
			if x["Type"] == "full_title":
				value_instance.set_meta("title", x["Title"])
				offset = offset + 52
			if x["Type"] == "input_field" or x["Type"] == "input_field_labeled":
				if x.has("Label"):
					value_instance.get_node("Label").text = x["Label"]
				if x.has("Measurement"):
					value_instance.get_node("Measurement").text = x["Measurement"]
				value_instance.get_node("Input").text = x["Text"]
				offset = offset + 44
			if x["Type"] == "toggle_labeled":
				if x.has("Label"):
					value_instance.get_node("Label").text = x["Label"]
				value_instance.set_meta("toggled", x["Toggled"])
				value_instance.get_node("Toggle")._set_state(x["Toggled"])
				offset = offset + 44
			if x["Type"] == "dropdown":
				selected = x["Selected"]
				value_instance.set_meta("selected", selected)
				value_instance.set_meta("inputs", values)
				value_instance.get_node("Label").text = x["Selected"]
				value_instance.set_meta("elements", x["Elements"])
				offset = offset + 40
				
			if x.has("ShowSelected"):
				if x["ShowSelected"] == selected:
					value_instance.visible = true
				else:
					value_instance.visible = false
					offset = original_offset
			$UI/BehaviourEdit/Inputs.add_child(value_instance)
			value = value + 1
	else:
		var value_instance = load("res://behaviour_editor_input_scenes/" + "no_input_fields" + ".tscn").instantiate()
		value_instance.position = Vector2(origin.x, origin.y + offset)
		$UI/BehaviourEdit/Inputs.add_child(value_instance)
		
	inputs_element_offset = offset
		
func _edit_behaviour_value(value, new, edits):
	for x in $Node2D/Behaviours.get_children():
		if x.name == get_node(editing_behaviour).name:
			var test = str(x.get_meta("values"))
			var fart = str_to_var(test)
			fart[value][edits] = new
			x.set_meta("values", fart)
	
func _close_behaviour_list():
	if behaviour_list_open:
		behaviour_list_open = false
		$UI/BehaviourList/AnimationPlayer.play_backwards("open")
	
func _open_behaviour_list():
	if not behaviour_list_open:
		behaviour_list_open = true
		$UI/BehaviourList/AnimationPlayer.play("open")

func _create_behaviour_list(search = ""):
	_erase_behaviour_list()
	list_element_offset = -40
	
	# MAKE IT SO LIKE THE CATEGROY OF THE SPAWNED BEHAVIOUR IS THE SAME AS THE ELEMENT ITS PULLED FORM, MAKLE SURE ELEMENT CATERGORY IS ACCURATE
	selected_catergory_colour = catergory_colours[selected_catergory]
	
	if not search == "":
		list_element_offset = 0
		for x in behaviours_list:
			for y in behaviours_list[x]:
				for z in behaviours_list[x][y]:
					if z.capitalize().contains(search.capitalize()):
						_create_behaviour_list_element(z, catergory_colours[x])
	else:
		if behaviours_list.has(selected_catergory):
			for x in behaviours_list[selected_catergory]:
				_create_behaviour_list_title(str(x))
				for y in behaviours_list[selected_catergory][x]:
					_create_behaviour_list_element(y, selected_catergory_colour)
	
	if $UI/BehaviourList/Elements.position.y < -list_element_offset:
		$UI/BehaviourList/Elements.position.y = 0
		
	_open_behaviour_list()
	
func _erase_behaviour_list():
	for x in get_node("UI/BehaviourList/Elements").get_children():
		x.queue_free()

var list_element_offset = -30

func _create_behaviour_list_element(name, colour):
	var element_scene = load("res://behaviour_list_element.tscn").instantiate()
	element_scene.position = Vector2(9, 150 + list_element_offset)
	element_scene.get_node("BG").modulate = Color(colour)
	element_scene.get_node("Label").text = name
	get_node("UI/BehaviourList/Elements").add_child(element_scene)
	list_element_offset = list_element_offset + 62

func _create_behaviour_list_title(name):
	var element_scene = load("res://behaviour_list_title.tscn").instantiate()
	element_scene.position = Vector2(9, 150 + list_element_offset)
	element_scene.get_node("Label").text = name
	get_node("UI/BehaviourList/Elements").add_child(element_scene)
	list_element_offset = list_element_offset + 62

func _on_button_button_down():
	OS.shell_open("https://www.hyperpad.com/learn")

func _on_back_button_down():
	print(_compile())
	$UI/Loading.set_meta("text", "Loading Editor...")
	$UI/Loading.visible = true
	await get_tree().create_timer(1).timeout
	$UI/Loading.visible = false
	OS.alert("Someday fr", "Editor not implemented yet!")

func _on_play_button_down():
	$UI/Loading.set_meta("text", "Preparing Player...")
	$UI/Loading.visible = true
	await get_tree().create_timer(1).timeout
	$UI/Loading.visible = false
	OS.alert("Someday fr", "Player not implemented yet!")

func _on_compile_button_down():
	_count_behaviours()
	_compile()

func _count_behaviours():
	var behaviour_amount = 0
	for x in behaviours_list:
		for y in behaviours_list[x]:
			for z in behaviours_list[x][y]:
				print(z)
				behaviour_amount = behaviour_amount + 1
	print("There a " + str(behaviour_amount) + "Behaviours in total.")

func _on_search_text_changed(new_text):
	if new_text == "":
		_create_behaviour_list()
	else:
		_create_behaviour_list(new_text)


func _on_active_toggle_button_down():
	if get_node(editing_behaviour).get_meta("active"):
		_behaviour_on_off(false)
	else:
		_behaviour_on_off(true)

func _behaviour_on_off(boolean):
	get_node(editing_behaviour).set_meta("active", boolean)
	if boolean:
		$UI/BehaviourEdit/BG/BG3/ActiveToggle.text = "On"
		$UI/BehaviourEdit/BG/BG3/ActiveToggle.modulate = Color("00bb78")
	else:
		$UI/BehaviourEdit/BG/BG3/ActiveToggle.text = "Off"
		$UI/BehaviourEdit/BG/BG3/ActiveToggle.modulate = Color("ffffffae")

func _on_unlink_button_button_down():
	get_node(editing_behaviour)._unlink()

func _on_duplicate_button_button_down():
	var behaviour_position = get_node(editing_behaviour).position
	var behaviour_size_x = get_node(editing_behaviour).get_node("Base").size.x
	_open_behaviour_menu(spawn_behaviour(get_node(editing_behaviour).get_meta("name"), "Node2D/Behaviours", get_node(editing_behaviour).get_meta("colour"), true).get_path())
	get_node(editing_behaviour).position = behaviour_position
	get_node(editing_behaviour).position.x = behaviour_position.x + behaviour_size_x

func _on_delete_button_button_down():
	if is_instance_valid(get_node(editing_behaviour)):
		get_node(editing_behaviour)._delete()
		_close_behaviour_menu()
		_open_behaviour_list()

func _on_bg_mouse_entered():
	mouse_location = "BG"
	can_move_cam = true

func _on_bg_mouse_exited():
	mouse_location = ""
	can_move_cam = true
