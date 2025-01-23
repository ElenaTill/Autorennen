extends Node2D
signal win(paneln)


@export var transition: PackedScene

### Internal Constants
var auto_speed = 25


### Variables
var active = false
var spawn_ready = false

var pos = Vector2 (0,0)
var v = Vector2 (0,0)


func set_active(b):
	active = b
	if active == true:
		$MusicPlayer.resume()
	else:
		$MusicPlayer.pause()
	
func new_game():
	$Timer.stop()
	$Auto.position.x = 0
	$Auto.position.y = 0
	

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

	
func gamelost():
	disable("Signal Lost", Color(0.5, 0., 0, 0))


func _ready():
	pass
	var music = preload("res://music/mgame4.mp3")
	$MusicPlayer.start(music)

func _process(delta):
	$Label.text = "%3.2f"%($Timer.time_left)

	if Input.is_action_just_pressed("newgame"):
		enable()
	if Input.is_action_pressed("Up") and active == true:
		v = Vector2 (0,-17)
		$Auto.position.y -= auto_speed * delta
		# change vector v
	if Input.is_action_pressed("Left") and active == true:
		v = v.rotated (PI/-100)
		$Auto/Sprite2D.rotation -= PI/100
		# change vector v
	if Input.is_action_pressed("Right") and active == true:
		v = v.rotated (PI/100)
		$Auto/Sprite2D.rotation += PI/100
		# change vector v
	if Input.is_action_pressed("Down") and active == true:
		$Auto.position.y += auto_speed * delta
		# change vector v
		
	# change position 
	pos = pos + delta * v
	$Auto.position = pos
	


func _on_auto_area_entered(area: Area2D) -> void:
	if area == $Strecke:
		print("Game Over")
		gamelost()
		
	#lost.emit()
	#if area == $Startbox:
		
	#print(area)


func _on_auto_area_exited(area: Area2D) -> void:
	if area == $Startbox:
		print("Startbox Verlassen")
		$Timer.start()
	if area == $Ziellinie:
		$Timer.stop()
		print("You Won")
		gamewon()
		
		
		

func _on_timer_finished():
	print ("Time Out")


func _on_timer_timeout() -> void:
	gamelost()
	
	
