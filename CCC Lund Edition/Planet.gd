extends Area2D

@export var vel_base = 5
var vel

# Called when the node enters the scene tree for the first time.
func _ready():
	vel = vel_base # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= vel * delta
