extends Label
var dottime = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	text = ""
	dottime = 0.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dottime += delta
	if dottime > 0.3:
		dottime = 0
		text += "."
		if len(text) > 3:
			text = ""
		
