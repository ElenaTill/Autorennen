extends Node2D

var pp = 0
var ppstep = PI/20
# Called when the node enters the scene tree for the first time.
func _ready():
	$Title.modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pp += ppstep * delta
	
	$Title.position.y += sin(pp) * 0.3
	$Title.modulate.a = sin(pp)**4
	#$Title.scale = Vector2(sin(pp)*0.1+1, sin(pp)*0.1+1)
	
	if pp > PI:
		queue_free()
