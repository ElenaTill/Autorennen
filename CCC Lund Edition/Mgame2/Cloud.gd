extends Area2D

@export var scale_inc = 1.03
@export var alpha_inc = 0.95
@export var rot_inc = PI/30

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(0.1, 0.1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale = scale * scale_inc
	rotation += rot_inc
	$Sprite2D.modulate.a *= alpha_inc
	if $Sprite2D.modulate.a < 0.001 or abs(position.x) > 47 or abs(position.y) > 47: 
		queue_free()
	
