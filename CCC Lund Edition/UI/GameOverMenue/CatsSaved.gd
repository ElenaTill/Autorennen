extends Node2D

@export var cats: PackedScene 

var start_anim = false
var ncats = 42
var cat_counter = 0
var finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ncats = 42
	start_anim = false
	visible = false
	cat_counter = 0
	$"Cats Saved/CatCounter".text = str(cat_counter)
	finished = false

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_anim == true:
		$SpawnTimer.start()
		visible = true
		start_anim = false

func spawn_cat():
	var c = cats.instantiate()
	c.z_index = 100
	c.position = Vector2(randi_range(1000,1200), 400)
	var size = 0.5 + randf()
	c.propel()
	c.add_to_group("Cats")
	add_child(c)

func _on_spawn_timer_timeout():
	$SpawnTimer.wait_time *= 0.9
	cat_counter += 1
	$"Cats Saved/CatCounter".text = str(cat_counter)
	spawn_cat()
	$SpawnTimer.start()
	if cat_counter > ncats:
		$SpawnTimer.stop()
		finished = true
		cat_counter = 0
