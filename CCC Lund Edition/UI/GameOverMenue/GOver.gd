extends Node2D
var start_anim = false
var speed = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(0, 0)
	speed = 20
	start_anim = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_anim == true:
		position.x += speed * delta
		speed *= 0.999
