extends Area2D

signal newgame
var spawn_in = false
var de_spawn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("GameOvers")
	$Sprite2D.modulate.a = 0
	$Message.modulate.a = 0
	$Timer.wait_time = 0.5

func spawn(text, color = Color(0.5, 0., 0., 1)):
	$Message.text = text
	spawn_in = true
	$Timer.start()
	$Message.modulate = color

func despawn():
	de_spawn = true
	$Timer.start()
	newgame.emit()

func despawn_instant():
	de_spawn = false
	spawn_in = false
	queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawn_in == true:
		$Sprite2D.modulate.a += 0.05
		$Message.modulate.a += 0.05
	if de_spawn == true:
		$Sprite2D.modulate.a -= 0.05
		$Message.modulate.a -= 0.05

func _on_timer_timeout():
	if de_spawn == true:
		queue_free()
	de_spawn = false
	spawn_in = false
