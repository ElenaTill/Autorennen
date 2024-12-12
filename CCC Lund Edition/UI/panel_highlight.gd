extends Area2D
var vel = 1.

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(8, 8)
	modulate = Color(1, 1, 1, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vel += 0.002
	modulate.a *= 0.98
	scale *= vel
	visible = not visible
	if modulate.a < 0.1:
		queue_free()
