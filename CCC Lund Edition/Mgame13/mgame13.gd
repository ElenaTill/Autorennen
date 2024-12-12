extends Node2D
var active = false
var spawn_ready = false
signal lost(paneln)
signal win(paneln)

@export var transition: PackedScene

### Internal Constants
var auto_speed = 25

### Variables

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
	win.emit(5)
	
func gamelost():
	disable("Signal Lost", Color(0.5, 0., 0, 0))
	lost.emit(5)

func _ready():
	pass
	var music = preload("res://music/mgame4.mp3")
	$MusicPlayer.start(music)

func _process(delta):
	if Input.is_action_just_pressed("newgame"):
		enable()
	if Input.is_action_pressed("Up") and active == true:
		$Auto.position.y -= auto_speed * delta
	if Input.is_action_pressed("Left") and active == true:
		$Auto.position.x -= auto_speed * delta
	if Input.is_action_pressed("Right") and active == true:
		$Auto.position.x += auto_speed * delta
	if Input.is_action_pressed("Down") and active == true:
		$Auto.position.y += auto_speed * delta

func _on_auto_area_entered(area: Area2D) -> void:
	if area == $Strecke:
		print("Game Over")
		lost.emit()
	#lost.emit()
	#if area == $Startbox:
		
	#print(area)


func _on_auto_area_exited(area: Area2D) -> void:
	if area == $Startbox:
		print("Startbox Verlassen")
		$Timer.start()


func _on_ziellinie_area_entered(area: Area2D) -> void:
	if area == $Ziellinie:
		print("You Won")
		win.emit()
