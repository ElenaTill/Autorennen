extends Area2D
@export var vel = 1
@export var dir = Vector2(-1, -1)
@export var bound = [-50, 50, -50, 50]

# Called when the node enters the scene tree for the first time.
func _ready():
	vel = randi_range(1, 4) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += dir * vel
	modulate.a *=0.95
	dir += Vector2(randf_range(-0.1, 0.1), randf_range(-0.1, 0.1))
	if position.x < bound[0] or position.x > bound[1]:
		queue_free()
	if position.y < bound[2] or position.y > bound[3]:
		queue_free()
