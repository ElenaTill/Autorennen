extends Area2D

signal newgame
var spawn_in = false
var de_spawn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.modulate.a = 0
	$Message.modulate.a = 0
	$Timer.wait_time = 3

func spawn(text):
	$Message.text = "You Died!"
	spawn_in = true
	$Timer.start()

func despawn():
	de_spawn = true
	$Timer.start()
	newgame.emit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($Timer.time_left)
	if spawn_in == true:
		$Sprite2D.modulate.a += 0.01
		$Message.modulate.a += 0.01
	if de_spawn == true:
		$Sprite2D.modulate.a -= 0.01
		$Message.modulate.a -= 0.01




func _on_timer_timeout():
	#if de_spawn == true:
		#queue_free()
	de_spawn = false
	spawn_in = false
