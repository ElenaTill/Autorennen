extends Label
var trans = false
var speed = 3000

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = -2000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if trans == true:
		position.x += speed * delta
		if position.x > -50:
			speed *= 0.8
		
