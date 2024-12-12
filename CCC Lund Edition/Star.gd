extends Area2D

var svel

# Called when the node enters the scene tree for the first time.
func _ready():
	svel = abs(randfn(1, 0.5))
	modulate.a = svel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= svel
	if position.x < -48:
		queue_free()
