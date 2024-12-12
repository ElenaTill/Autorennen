extends Sprite2D
var start_anim = false

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(2,2)
	rotation = 0
	start_anim = false
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_anim == true:
		visible = true
		scale *= 1.0001
		rotation += PI / 500 * delta
