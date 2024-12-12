extends Node2D
var active = false
var spawn_ready = false
signal lost(paneln)
signal win(paneln)

@export var buttons: PackedScene
@export var transition: PackedScene

### Internal Constants
var cpos = 0
var pressed = []
var uppos = 38
var downpos = 42
var handpos = [Vector2(-27, 38), Vector2(-6, 38), Vector2(12, 38), Vector2(32, 38)]
var button_color = ["blue", "green", "red", "yellow"]
var button_index = [1, 2, 3, 4]

#Variables
var nbutton = 3
var button_list = [4, 1, 2]

func generate_sequence():
	button_list = []
	for n in nbutton:
		button_list.append(randi_range(1,4))
	for child in $HFlowContainer.get_children():
		child.queue_free()

func handle_press():
	if pressed.size() >= nbutton:
		pressed = []
	pressed.append(button_index[cpos])
	
	if pressed == button_list:
		disable("You survived!", Color(0, 0.5, 0, 0))
		$Timer.stop()
		win.emit(4)
	
	for child in $HBoxContainer.get_children():
		child.queue_free()
	for p in pressed:
		var butt = buttons.instantiate()
		butt.get_node("AnimatedSprite2D").play(button_color[p-1])		
		butt.get_node("AnimatedSprite2D").scale = Vector2(0.5, 0.5)
		$HBoxContainer.add_child(butt)
	
func handle_input(dir):
	if cpos+dir<0:
		cpos = 0
	elif cpos+dir>3:
		cpos = 3
	else:
		cpos += dir

func set_active(b):
	active = b
	if active == true:
		$MusicPlayer.resume()
	else:
		$MusicPlayer.pause()
	
func new_game():
	pressed = []
	$Timer.start()
	generate_sequence()
	$Timer.start()
	for b in button_list:
		var butt = buttons.instantiate()
		butt.get_node("AnimatedSprite2D").play(button_color[b-1])		
		$HFlowContainer.add_child(butt)

func enable():
	if get_node("GameOver"):
		get_node("GameOver").despawn()
	spawn_ready = false
	new_game()

func disable(text, color):
	$Timer.stop()
	var trans = transition.instantiate()
	add_child(trans)
	trans.spawn(text, color)
	spawn_ready = true


# Called when the node enters the scene tree for the first time.
func _ready():
	var music = preload("res://music/mgame4.mp3")
	$MusicPlayer.start(music)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$m4Player.position = handpos[cpos]
	$Countdown.text = "%3.2f"%$Timer.time_left
	if Input.is_action_just_pressed("newgame"):
		enable()
	if Input.is_action_just_pressed("Left"):
		handle_input(-1)
	if Input.is_action_just_pressed("Right") and active == true:
		handle_input(1)
	if Input.is_action_pressed("Space") and active == true:
		$m4Player.position.y = downpos
	if Input.is_action_just_released("Space") and active == true:
		$m4Player.position.y = uppos
		handle_press()


func _on_timer_timeout():
	disable("Signal Lost", Color(0.5, 0., 0, 0))
	lost.emit(4)
