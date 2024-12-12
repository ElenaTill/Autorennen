extends Area2D

@export var vel = 0.05
var rot_acc = PI/3000
var rot_vel = randf_range(-PI/30, PI/30)
@export var heat_meter = 0
var norm_angle
@export var heat_inc = 0.3

@onready var parentN = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	vel = 0.05
	rot_acc = PI/3000
	heat_inc = 0.3
	$Spritegroup/Heat.modulate = Color(0, 0, 0, 1)
	rot_vel = randf_range(-PI/30, PI/30)
	position = Vector2(-30, -20)
	heat_meter = 0
	$Spritegroup/HeatOutline.modulate = Color(1, 1, 1, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += rot_vel * delta * 80
	position += Vector2(1, 1) * vel * delta * 50
	$Spritegroup/Heat.modulate = Color(heat_meter/100., 0.2, 0.2, 10)
	
	if Input.is_action_pressed("Left") and parentN.active == true:
		rot_vel -= rot_acc
	if Input.is_action_pressed("Right") and parentN.active == true:
		rot_vel += rot_acc
	
	norm_angle = int(rotation_degrees)%360
	if norm_angle < 0:
		norm_angle += 360
	if norm_angle > 15 and norm_angle < 75:
		heat_meter += heat_inc
		$Spritegroup/HeatOutline.modulate = Color(0, 1, 0, 1)
		parentN.get_node("Good").visible = true
		parentN.get_node("Bad").visible = false
		if heat_meter > 100:
			heat_meter = 100
	else:
		$Spritegroup/HeatOutline.modulate = Color(1, 0, 0, 1)
		parentN.get_node("Good").visible = false
		parentN.get_node("Bad").visible = true
		heat_meter -= heat_inc*0.5
		if heat_meter < 0:
			heat_meter = 0
		

		
