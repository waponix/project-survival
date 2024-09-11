@tool
extends Node3D

@onready var player := $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	RenderingServer.global_shader_parameter_set("player_position", player.global_transform.origin);
	RenderingServer.global_shader_parameter_set("camera_position", player.get_node('TwistPivot/PitchPivot/Camera3D').global_transform.origin);
