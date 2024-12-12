extends Node2D

@export var pvel = 15
@export var star_scene: PackedScene
@export var transition: PackedScene
var active = false
var spawn_ready = false

signal win(paneln)
signal lost(paneln)

func new_game():
	$Player/AnimatedSprite2D.play("default")
	$winzone/CollisionShape2D.set_deferred("disabled", false)
	$Player/CollisionShape2D.set_deferred("disabled", false)
	$asteroid/CollisionShape2D.set_deferred("disabled", false)
	$Player.position = Vector2(-30, 0)
	$asteroid.position = Vector2(40, randf_range(-25, 25))
	$asteroid.visible = true
	for n in 10:
		var star = star_scene.instantiate()
		star.position = Vector2(randf_range(-47, 47), randf_range(-47, 47))
		add_child(star)

func disable(text, color):
	$Player/CollisionShape2D.set_deferred("disabled", true)
	$winzone/CollisionShape2D.set_deferred("disabled", true)
	$asteroid/CollisionShape2D.set_deferred("disabled", true)
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
	#print($MusicPlayer/AudioStreamPlayer.stream_paused)
	if active == true:
		$MusicPlayer.resume()
	else:
		$MusicPlayer.pause()

func _ready():
	var music = preload("res://music/mgame1.mp3")
	$MusicPlayer.start(music)


func _process(delta):
	$Marker.position = $asteroid.position
	$Marker.visible = $asteroid.visible
	if Input.is_action_pressed("Down") and active == true:
		$Player.position.y += pvel * delta
	if Input.is_action_pressed("Up") and active == true:
		$Player.position.y -= pvel * delta
	if Input.is_action_pressed("newgame"):
		enable()
	if randf()<0.1:
		var star = star_scene.instantiate()
		star.position = Vector2(47, randf_range(-47, 47))
		add_child(star)

func _on_asteroid_area_entered(area):
	if area == $Player:
		$Player/AnimatedSprite2D.play("die") # Replace with function body.
		disable("Signal Lost", Color(0.5, 0., 0, 0))
		lost.emit(1)


func _on_winzone_win():
	disable("You survived!", Color(0, 0.5, 0, 0))
	win.emit(1)
