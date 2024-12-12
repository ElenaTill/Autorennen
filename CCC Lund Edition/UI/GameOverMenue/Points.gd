extends Node2D

@export var cats: PackedScene 

var start_anim = false
var npoints = 42
var point_counter = 0
var finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	npoints = 10001
	start_anim = false
	visible = false
	point_counter = 0
	finished = false
	$Points/PointCounter.text = str(point_counter)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_anim == true:
		$PointTimer.start()
		visible = true
		start_anim = false

func spawn_cat():
	var c = cats.instantiate()
	c.position = Vector2(randi_range(1000,1200), 400)
	var size = 0.5 + randf()
	c.propel()
	c.add_to_group("Cats")
	add_child(c)
	c.get_node("RigidBody2D/AnimatedSprite2D").frame = 18

func _on_spawn_timer_timeout():
	$PointTimer.wait_time *= 0.5
	point_counter += 50
	$Points/PointCounter.text = str(point_counter)
	if point_counter % 50 == 0:
		spawn_cat()
	$PointTimer.start()
	if point_counter > npoints:
		$Points/PointCounter.text = str(npoints)
		$PointTimer.stop()
		finished = true
		point_counter = 0
