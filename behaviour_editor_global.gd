extends Node

var behaviour_creator_scene = preload("res://behaviour_creator.tscn")
var behaviour_editor_scene = preload("res://behaviour_editor.tscn")

var grabbing_behaviour = false
var grabbed_behaviour = ""
var grabbed_behaviour_colour

var hovering_behaviour = false
var hovering_over_behaviour

var connecting_behaviour = false
var reconnecting_behaviour = false
var connected_nub_owner
var connector_behaviour

var camera_zoom = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
