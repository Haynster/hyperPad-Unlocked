extends Control

var input_fields = {
	"full_title": {"Title": "Event", "ShowSelected": "", "Output": ""},
	"title": {"Title": "Event", "ShowSelected": "", "Output": ""},
	"toggle_labeled": {"Label": "", "Toggled": true, "ShowSelected": "", "Output": ""},
	"input_field": {"Text": "", "Measurement": "", "ShowSelected": "", "Output": ""},
	"input_field_labeled": {"Text": "", "Measurement": "", "Label": "", "ShowSelected": "", "Output": ""},
	"dropdown": {"Selected": "On Press", "Elements": [], "ShowSelected": "", "Output": ""},
}

var elements = []
var outputs = []
var editing_element = {}

var editing_behaviour = ""

var behaviour_description = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_drop_down_selected_changed("title")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$JSON.text = str(elements)
	var origin = Vector2(8, 0)
	var offset = 0
	for y in $Elements.get_children():
		y.queue_free()
	for x in elements:
		var element_edit = load("res://behaviour_creator_element.tscn").instantiate()
		element_edit.position = Vector2(origin.x, origin.y + offset)
		element_edit.text = x["Type"]
		element_edit.set_meta("value", offset / 32)
		offset = offset + 32
		$Elements.add_child(element_edit)

func _on_done_button_down():
	$AddElement.visible = false
	if editing_element["ShowSelected"] == "":
		editing_element.erase("ShowSelected")
	if editing_element["Output"] == "":
		editing_element.erase("Output")
	elements.append(editing_element)
	
var origin = Vector2(0, 0)
var offset = 0
	
func _add_input_editor(t):
	var element_edit = load("res://behaviour_creator_element_edit.tscn").instantiate()
	element_edit.position = Vector2(origin.x, origin.y + offset)
	element_edit.set_meta("Title", t)
	offset = offset + 40
	$AddElement/Elements.add_child(element_edit)

func _on_add_button_down():
	$AddElement.visible = true

func _on_drop_down_selected_changed(new):
	offset = 0
	for y in $AddElement/Elements.get_children():
		y.queue_free()
	for x in input_fields[new]:
		_add_input_editor(x)
		
	editing_element = input_fields[new]
	editing_element["Type"] = new

func element_changed(new, obj):
	if obj.get_meta("Title") == "Elements":
		editing_element[obj.get_meta("Title")] = str_to_var(new)
	if obj.get_meta("Title") == "Description":
		behaviour_description = new
	else:
		editing_element[obj.get_meta("Title")] = new

func _on_save_button_down():
	$FileDialogSave.visible = true

func _on_file_dialog_dir_selected(dir):
	save(dir + "/" + editing_behaviour  + ".json")

func save(path):
	var file = FileAccess.open(path, FileAccess.WRITE)
	var finaljson = {"inputs": [], "outputs": [], "description": behaviour_description}
	var value = 0
	for x in elements:
		if x.has("Output"):
			finaljson["outputs"].append(value)
		finaljson["inputs"].append(x)
		value = value + 1
	file.store_line(str(finaljson))

func _on_line_edit_text_changed(new_text):
	editing_behaviour = new_text

func _delete_element(e):
	elements.remove_at(e)

func _on_load_button_down():
	$FileDialogLoad.visible = true

func _on_file_dialog_load_file_selected(path):
	var file = FileAccess.open(path, FileAccess.READ)
	elements = str_to_var(file.get_as_text())
	$LineEdit.text = path.get_file().left(path.get_file().length() - 5)
	editing_behaviour = $LineEdit.text

func _on_button_button_down():
	$Loading.set_meta("text", "Loading Editor...")
	$Loading.visible = true
	await get_tree().create_timer(0.5).timeout
	$Loading.visible = false
	get_tree().change_scene_to_packed(BEGlobal.behaviour_editor_scene)
