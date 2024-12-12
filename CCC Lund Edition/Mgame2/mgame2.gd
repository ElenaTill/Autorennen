extends Node2D

var launch_ready = true
var active = false
var spawn_ready = false

signal launch
signal win(paneln)
signal lost(paneln)

@export var cloud_scene: PackedScene
@export var transition: PackedScene

# Called when the node enters the scene tree for the first time.

func new_game():
	$PlayerM2._ready()
	$Planet._ready()
	$winzone._ready()
	$Arrow._ready()
	launch_ready = true
	$Planet.position = Vector2(35, -25)
	$Arrow.position = Vector2(10, 25)
	$PlayerM2.position = Vector2(10,25)
	
	$PlayerM2/CollisionShape2D.set_deferred("disabled", false)
	$Planet/CollisionShape2D.set_deferred("disabled", false)
	$Arrow.visible = true

	
func disable(text, color):
	$PlayerM2.vel = 0
	$PlayerM2.vel_inc = 0
	$Planet.vel = 0
	$PlayerM2/CollisionShape2D.set_deferred("disabled", true)
	$Planet/CollisionShape2D.set_deferred("disabled", true)
	var trans = transition.instantiate()
	add_child(trans)
	trans.spawn(text, color)
	spawn_ready = true

func enable():
	if get_node("GameOver"):
		get_node("GameOver").despawn()
	spawn_ready = false
	new_game()

func set_active(b):
	active = b
	if active == true:
		$MusicPlayer.resume()
	else:
		$MusicPlayer.pause()
		
func _ready():
	var music = preload("res://music/mgame2.mp3")
	$MusicPlayer.start(music)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("newgame"):
		enable()
	if Input.is_action_just_pressed("Space") and launch_ready == true and active == true:
		launch.emit($Arrow.rotation)
		$Arrow.visible = false
		launch_ready = false
	if launch_ready == false:
		var cloud = cloud_scene.instantiate()
		cloud.position = $PlayerM2.position
		add_child(cloud)


func _on_planet_area_entered(area):
	if area == $PlayerM2:
		disable("You survived!", Color(0, 0.5, 0, 0))
		win.emit(2)
	if area == $winzone:
		disable("Signal Lost", Color(0.5, 0., 0, 0))
		lost.emit(2)
