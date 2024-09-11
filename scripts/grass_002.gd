extends ParentNode3D

@onready var plane: Node3D = $Plane_002

func _ready() -> void:
	_hidable_nodes = [plane]
	

func _on_visible_on_screen_notifier_3d_screen_entered():
	_toggle_visibility()


func _on_visible_on_screen_notifier_3d_screen_exited():
	_toggle_visibility()
