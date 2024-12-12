extends Node

var fade_in = false
var fade_out = false
var db_current 
@export var db_min = -40
@export var fade_time = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.stream_paused = true
	$AudioStreamPlayer.volume_db = db_min
	$Timer.wait_time = fade_time

func _process(delta):
	if fade_in == true:
		db_current = $Timer.time_left/$Timer.wait_time * db_min
		$AudioStreamPlayer.volume_db = db_current
		if db_current > -0.01:
			fade_in = false
	
	if fade_out == true:
		db_current = (1 - $Timer.time_left/$Timer.wait_time) * db_min
		$AudioStreamPlayer.volume_db = db_current
		if db_current < -39.99:
			fade_out = false
			$AudioStreamPlayer.stream_paused = true
		
func start(Music):
	#print("Start")
	$AudioStreamPlayer.stream = Music
	$AudioStreamPlayer.play()
	_ready()

func mute():
		$AudioStreamPlayer.stream_paused = true	

func resume():
	#if $AudioStreamPlayer.playing == false:
	#	$AudioStreamPlayer.play()
	$AudioStreamPlayer.stream_paused = false
	if fade_in != true:
		$Timer.start()
	fade_in = true

func pause():
	$AudioStreamPlayer.stream_paused = false
	if fade_out != true:
		$Timer.start()
	fade_out = true
	
func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
