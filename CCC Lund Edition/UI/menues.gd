extends Node2D
var trans_speed = 10000
var trans_active = false
var menue_state = false
signal pause
signal reset

# Called when the node enters the scene tree for the first time.
func _ready():
	$MenueItems.visible = false
	#$Transition.position = Vector2(-2000, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Q") and menue_state == true: 
		get_tree().quit()
	if Input.is_action_just_pressed("R") and menue_state == true: 
		reset.emit()
		trans_active = true
		if menue_state == true:
			$MenueItems.visible = false
	if Input.is_action_just_pressed("Menue") and $"../..".menue_enabled == true:
		trans_active = true
		if menue_state == true:
			$MenueItems.visible = false
			$MenueItems/Highscore._ready()
		pause.emit()
	if trans_active == true:
		if menue_state == false:
			$Transition.position.x += trans_speed * delta
			if $Transition.position.x > 1100 * 2:
				$Transition.position.x = 1100 * 2
				menue_state = true
				trans_active = false
				$MenueItems.visible = true
				$MenueItems/Highscore.start = true
		else:
			$Transition.position.x -= trans_speed * delta
			if $Transition.position.x < 0:
				$Transition.position.x = 0
				menue_state = false
				trans_active = false
				
				
		
