extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$RigidBody2D/AnimatedSprite2D.frame = randi_range(0, 17)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func propel():
	$RigidBody2D.apply_impulse(Vector2(randi_range(-500, -1000), randi_range(-300, -600)))

func despawn():
	queue_free()
