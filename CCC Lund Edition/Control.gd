extends Control


# Called when the node enters the scene tree for the first time.

func spawn_guide(text, keys):
	$Description.text = text
	_ready()
	for k in keys:
		var N = get_node(k)
		N.visible = true

func _ready():
	$Left.visible = false # Replace with function body.
	$Right.visible = false
	$Up.visible = false
	$Down.visible = false
	$Space.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
