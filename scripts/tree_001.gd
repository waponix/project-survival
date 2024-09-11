extends ParentNode3D

@onready var tree := $Tree
@onready var stump := $Stump

# Called when the node enters the scene tree for the first time.
func _ready():
	_hidable_nodes = [tree]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_3d_screen_entered():
	_toggle_visibility()

func _on_visible_on_screen_notifier_3d_screen_exited():
	_toggle_visibility()
