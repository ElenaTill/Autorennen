extends Node2D

var menu_active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var music = preload("res://music/MainTheme.mp3")
	$MusicPlayer.start(music)
	$MusicPlayer.resume()
	$"Cat/Suite/Suite Lights".visible = false
	$Background/BackgroundLights.visible = false
	$Timer.start()
	$Timer2.start()
	$Story2/Story3.visible = false
	$Story2/Story3/TextHighlight.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Input.is_anything_pressed()
	if Input.is_anything_pressed() and menu_active == true:
		$Fade2.run_animation = true
		await get_tree().create_timer(0.5).timeout
		$MainLabel.queue_free()
		$Background.queue_free()
		$Cat.queue_free()
		$MusicPlayer.pause()
		$Timer.queue_free()
		$Timer2.queue_free()
		$Story2.queue_free()
		$Fade2.visible = false
		menu_active = false
		
		# Transition to next Scene
		Globals.next_scene = "res://MainGame.tscn"
		get_tree().change_scene_to_packed(Globals.loading_screen)

func _on_timer_timeout():
	$Story2/Story3.visible = true
	$Story2/Story1.visible = false
	$Story2/Story2.visible = false
	$Story2/Story3/TextHighlight.visible = true
	$Story2/Story3.trans = true
	$Cat/HiddenFace.start_animation = true
	$Background.run_animation = false
	$"Cat/Suite/Suite Lights".visible = true
	$MainLabel.run_animation = true


func _on_timer_2_timeout():
	$Background/BackgroundLights.visible = true
	$Story2/Story1.speed = 1000
	$Story2/Story2.speed = 1000
