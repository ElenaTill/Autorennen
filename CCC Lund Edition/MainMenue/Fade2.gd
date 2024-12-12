extends Sprite2D
var run_animation = false
var speed = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if run_animation == true:
		position.x += speed * delta
	if position.x > 2000:
		queue_free()
