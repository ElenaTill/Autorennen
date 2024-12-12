extends Area2D

@export var vel_base = 0.5
var vel
@export var vel_inc_base = 0.25
var vel_inc
var launch
var vel_vec = Vector2(0, 0)

func set_vel_vec(rotation):
	vel_vec = Vector2(0, 1).rotated(rotation)

func _ready():
	vel_vec = Vector2(0, 0)
	vel = vel_base
	vel_inc = vel_inc_base

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if abs(position.x)>47 or abs(position.y)>47:
		pass
	else:
		position = position + vel_vec * delta * -vel
		vel += vel_inc
		

func _on_mgame_2_launch(rotation):
	set_vel_vec(rotation)
