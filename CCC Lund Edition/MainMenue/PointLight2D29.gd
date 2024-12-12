extends PointLight2D
var intense = PI/2
var phase = randi_range(200,600)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#intense += PI/phase
	energy = 4 + 3* sin(intense)
