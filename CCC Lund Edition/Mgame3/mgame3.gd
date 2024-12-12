extends Node2D

var active = false
var spawn_ready = false

@export var speed_scene: PackedScene
@export var transition: PackedScene

signal win(paneln)
signal lost(paneln)

func new_game():
	$m3Player.visible = true
	$m3Player._ready()
	$Marker.position.y = -40

func enable():
	$m3Player/CollisionShape2D.set_deferred("disabled", false)
	$winzone/CollisionShape2D.set_deferred("disabled", false)
	if get_node("GameOver"):
		get_node("GameOver").despawn()
	spawn_ready = false
	new_game()

func disable(text, color):
	$winzone/CollisionShape2D.set_deferred("disabled", true)
	$m3Player/CollisionShape2D.set_deferred("disabled", true)
	var trans = transition.instantiate()
	add_child(trans)
	trans.spawn(text, color)
	spawn_ready = true
	
func set_active(b):
	active = b
	if active == true:
		$MusicPlayer.resume()
	else:
		$MusicPlayer.pause()
	
func _ready():
	var music = preload("res://music/mgame3.mp3")
	$MusicPlayer.start(music)
	$m3Player.vel = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_just_pressed("newgame"):
		enable()
	for n in range(int($m3Player.heat_meter/20)):
		var speed = speed_scene.instantiate()
		speed.position = $m3Player.position + Vector2(randi_range(-10, 10), randi_range(-10, 10))
		var rr = randf() + $m3Player.heat_meter/100
		speed.modulate = Color(2 * rr, rr, 0.5, 1)
		add_child(speed)
		
	$Marker.position.y = $m3Player.heat_meter/100*80 - 40
	if $m3Player.heat_meter>99:
		disable("You survived!", Color(0, 0.5, 0, 0))
		win.emit(3)
		$m3Player.vel = 0
		$m3Player.heat_meter = 0
		$m3Player.heat_inc = 0
		$m3Player.rot_acc = 0


func _on_winzone_area_entered(area):
	if area == $m3Player:
		disable("Signal Lost", Color(0.5, 0., 0, 0))
		lost.emit(3) # Replace with function body.
		$m3Player.vel = 0
		$m3Player.heat_meter = 0
		$m3Player.heat_inc = 0
		$m3Player.rot_acc = 0
