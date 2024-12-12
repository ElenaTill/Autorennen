extends Area2D

@export var rot_vel = PI/2
var dir = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = randf_range(-PI/2, PI/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rotation >= PI/2:
		dir = dir * -1
		rotation = PI/2
	if rotation <= -PI/2:
		dir = dir * -1
		rotation = - PI/2
	rotation += rot_vel * delta * dir
