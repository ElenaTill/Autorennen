extends Node2D
var active = false
var spawn_ready = false
signal lost(paneln)
signal win(paneln)

@export var transition: PackedScene

### Internal Constants

## #Variables

func set_active(b):
	active = b
	if active == true:
		$MusicPlayer.resume()
	else:
		$MusicPlayer.pause()
	
func new_game():
	pass

func enable():
	if get_node("GameOver"):
		get_node("GameOver").despawn()
	spawn_ready = false
	new_game()

func disable(text, color):
	var trans = transition.instantiate()
	add_child(trans)
	trans.spawn(text, color)
	spawn_ready = true

func gamewon():
	disable("You survived!", Color(0, 0.5, 0, 0))
	win.emit(13)
	
func gamelost():
	disable("Signal Lost", Color(0.5, 0., 0, 0))
	lost.emit(13)

func _ready():
	pass
	var music = preload("res://music/mgame12.mp3")
	$MusicPlayer.start(music)

func _process(delta):
	if Input.is_action_just_pressed("newgame"):
		enable()
	if Input.is_action_pressed("Left") and active == true:
		pass
