extends Node2D

var run_animation = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if run_animation == true:
		position.y += 13 * delta
		scale *= 1.0001
		rotation += PI/1000 * delta
