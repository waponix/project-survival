@tool
extends Node3D

@onready var ground := $Ground

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	RenderingServer.global_shader_parameter_set("ground_position", ground.global_transform.origin);
