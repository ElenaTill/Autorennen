extends Node2D

var trans_speed = 10000
var trans_active = false
var menue_state = false
var cat_saved = false
var gameover_active = false
signal pause
signal reset

# Called when the node enters the scene tree for the first time.
func _ready():
	$SadCats.visible = false
	$Highscore.visible = false
	$MenueItems.visible = false
	$CreditScreen.visible = false
	$CreditScreen/Timer.stop()
	var music = preload("res://music/GameOverScreen.mp3")
	$MusicPlayer.start(music)
	#$Transition.position = Vector2(-2000, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cat_saved == true:
		$MusicPlayer/AudioStreamPlayer.play()
		$MusicPlayer.resume()
		$CatsSaved.start_anim = true
		$Transition/Background.start_anim = true
		cat_saved = false
	if $CatsSaved.finished == true:
		$CatsSaved.finished = false
		$Points.start_anim = true
	if $Points.finished == true:
		$Points.finished = false
		$MenueItems.visible = true
	if Input.is_action_just_pressed("Q") and menue_state == true: 
		get_tree().quit()
	if Input.is_action_just_pressed("R") and menue_state == true: 
		$Highscore._ready()
		$SadCats.visible = false
		$Highscore.visible = false
		$Points.visible = false
		$CatsSaved.visible = false
		$CreditScreen.visible = false
		$CreditScreen/Timer.stop()
		get_tree().call_group("Cats", "despawn")
		$MusicPlayer.pause()
		$Transition/GOver._ready()
		reset.emit()
		trans_active = true
		if menue_state == true:
			$MenueItems.visible = false
	if trans_active == true:
		if menue_state == false:
			$CatsSaved/SpawnTimer.wait_time = 0.5
			$Points/PointTimer.wait_time = 0.5
			$SadCats.visible = true
			$CreditScreen.visible = true
			$CreditScreen/Timer.start()
			$Highscore.visible = true
			$Highscore.start = true
			$Transition/Background._ready()
			$Transition.position.x += trans_speed * delta
			if $Transition.position.x > 1100 * 2:
				$Transition.position.x = 1100 * 2
				menue_state = true
				trans_active = false
				cat_saved = true
				$Transition/GOver.start_anim = true
		else:
			$Transition.position.x -= trans_speed * delta
			if $Transition.position.x < 0:
				$Transition.position.x = 0
				menue_state = false
				trans_active = false
				
				
		
