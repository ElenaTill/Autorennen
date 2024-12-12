extends PointLight2D
var intense = randf()
var phase = randi_range(20,60)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	intense += PI/phase
	energy = 3 + 3* sin(intense)
