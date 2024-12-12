extends Node2D

@onready var containers = [$"VBoxContainer/1",$"VBoxContainer/2",$"VBoxContainer/3",$"VBoxContainer/4",$"VBoxContainer/5",$"VBoxContainer/6",$"VBoxContainer/7",$"VBoxContainer/8",$"VBoxContainer/9",$"VBoxContainer/10"]
var n = 0
var run = false
var start = false


# Called when the node enters the scene tree for the first time.
func _ready():
	for cont in containers:
		cont.modulate.a = 0
	n = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start == true:
		$Timer.start()
		run = true
		start = false
	if run == true:
		containers[n].modulate.a += 0.1
		if containers[n].modulate.a > 1:
			containers[n].modulate.a = 1
	
	


func _on_timer_timeout():
	n+= 1
	if n == 10:
		run = false
		$Timer.stop()
		n = 0
		
