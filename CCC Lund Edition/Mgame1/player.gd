extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += PI/60
	position = position.clamp(Vector2(-35,-35), Vector2(35,35))

