extends Sprite2D
var start_animation = false
var run_animation = false
var speed = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	$PointLight2D3.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_animation == true:
		modulate.a = 0.99
		run_animation = true
		start_animation = false
		$PointLight2D3.visible = true
	if run_animation == true:
		$PointLight2D3.energy *= 0.9
		modulate.a *= 0.995
		rotation += PI/3 * delta
		position.x += speed * delta
		position.y += speed * delta * 0.1
		scale *= 1.03
