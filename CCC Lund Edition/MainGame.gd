extends Node

@export var panel_highlight: PackedScene
@export var bg_effect: PackedScene

var start_lives = 1
var max_strength = 0.5

### Internal Variables
var score = 0
var nlives = start_lives
var strength = max_strength
var score_inc = 0
var spawn_time = 60
var spawn_ready = []
var paused = false
var muted = true
var current_input = 0
var input_changed = true
var practice = true
var menue_enabled = true

var input_layout = "Unknown"
var input_layout_old = "Unknown"

@onready var games = [$Overview/SubViewport/Mgame1, $Overview/SubViewport/Mgame2, $Overview/SubViewport/Mgame3, $Overview/SubViewport/Mgame4, $Overview/SubViewport/Mgame13]
@onready var games_vec = [Vector2(0, 50), Vector2(240, 50), Vector2(480, 50), Vector2(720, 50), Vector2(0, 290)]
@onready var keys = [$UI/CanvasGroup/Key1, $UI/CanvasGroup/Key2, $UI/CanvasGroup/Key3, $UI/CanvasGroup/Key4, $UI/CanvasGroup/Key5]
@onready var keysb = ["1", "2", "3", "4", "Q", "W", "E", "R", "A", "S"]
@onready var panel_points = [0, 0, 0, 0, 0]
@onready var gameguide = ["Avoid the Asteroid!", "Launch Probe and hit Planet!", "Shield yourself from the Entrance Heat!", "Enter the Ejection Sequence!", "Land on the Farm!"]
@onready var gamekeys = [["Up", "Down"], ["Space"], ["Left", "Right"], ["Left", "Right", "Space"], ["Left", "Right"], ["Left", "Right", "Up"]]

func handle_controls(key):
	if key == "W":
		if current_input > 3:
			current_input -= 4
	if key == "S":
		if current_input < 11:
			current_input += 4
	if key == "A" :
		if current_input>0  and (current_input)%4 != 0:
			current_input -= 1
	if key == "D":
		if current_input<16 and (current_input+1)%4 != 0:
			current_input += 1
	if current_input > 4:
		current_input = 0

func toggle_mute_all():
	self.muted = !self.muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), self.muted)

func spawn_panel_highlight(gnumber):
	var phighlight = panel_highlight.instantiate()
	phighlight.position = games_vec[gnumber -1]
	$Overview/SubViewport.add_child(phighlight)
	
func setup_panel(gnumber):
	# Sets up the Panel und deactivates it
	games[gnumber - 1].position = games_vec[gnumber - 1]
	games[gnumber - 1].get_node("Border").visible = false
	games[gnumber - 1].scale = Vector2(2, 2)
	print(games[gnumber - 1])
	games[gnumber - 1].disable("No Signal", Color(1,1,1,0))
	
func activate_input(gnumber):
	# Handles Input logic
	# If called with Panel number, Panels gets active and controllable
	$Zoomview/SubViewport/Camera2D.offset = games_vec[gnumber - 1]
	deactive_all(games[gnumber - 1])
	if games[gnumber - 1].active == false:
		games[gnumber - 1].set_active(true)
	keys[gnumber - 1].modulate = Color(0.8, 0, 0, 1)
	$UI/CanvasGroup/SelectEffect.position = keys[gnumber - 1].position

func deactive_all(active_game):
	for game in games:
		if game.active == true and active_game != game:
			game.set_active(false)
	for key in keys:
		key.modulate = Color (1, 1, 1, 1)
		
func stop_music():
	for game in games:	
		game.get_node("MusicPlayer").mute()		
		
func reset_all():
	# Resets all games to its Beginning State
	score = 0
	nlives = start_lives
	strength = max_strength
	score_inc = 0
	for gnumber in len(panel_points):
		panel_points[gnumber] = 0
		keys[gnumber].get_node("Sprite2D").get_node("Label").text = str(panel_points[gnumber])
		
	spawn_ready = []
	
	update_score()
	update_lifes()
	update_signal()
	update_timer()
	
	current_input = 0
	activate_input(1)
	$UI/Guide.spawn_guide(gameguide[0], gamekeys[0])
	
	for g in games:
		g.get_tree().call_group("GameOvers", "despawn_instant")
	await get_tree().create_timer(0.5).timeout
	for game in games:		
		game.disable("No Signal", Color(1,1,1,0))
	stop_music()
	
	if practice == false:
		$GameLogic/SpawnTimer.start()
	else:
		$GameLogic/SpawnTimer.start()
		$GameLogic/SpawnTimer.stop()

func update_lifes():
	$UI/LivesLabel/Lives.text = str(nlives)
	
func update_timer():
	$UI/LoadingBar/LoadingLabel/Seconds.text = "%2.1f"%($GameLogic/SpawnTimer.time_left)

func update_signal():
	$UI/SignalLabel/Strength.text = "%3.0f%%"%(strength*100)

func update_score():
	$UI/Score/Points.text = str(score)
	$UI/Score/Increment.text = str(score_inc)

func update_loading_bar():
	$UI/LoadingBar/Bar.position.x = -(1 - $GameLogic/SpawnTimer.time_left / $GameLogic/SpawnTimer.wait_time) * 377
	
func setup_loading_bar():
	$GameLogic/SpawnTimer.wait_time = spawn_time

func launch_games():
	var remaining_spawns = []
	for s in spawn_ready:
		if games[s].spawn_ready == true:
			games[s].enable()
		else:
			remaining_spawns.append(s)
	spawn_ready = remaining_spawns

func launch_random_game():
	var spawned = false
	while spawned == false:
		var pspawn = randi_range(1, len(panel_points))
		if games[pspawn -1].active == false and games[pspawn -1].spawn_ready == true:
			spawn_ready.append(pspawn - 1)
			spawn_panel_highlight(pspawn)
			spawned = true

func pause_game(state):
	for g in games:
		g.set_process(state)

func _ready():
	
	$UI/Score.visible = false
	var bge = bg_effect.instantiate()
	$Overview/SubViewport.add_child(bge)
	
	$Zoomview/SubViewport.world_2d = $Overview/SubViewport.world_2d
	$Zoomview/SubViewport/Camera2D.offset = Vector2(0, 50)
	$Zoomview/SubViewport/Camera2D.zoom = Vector2(2, 2)
	
	for gnumber in len(panel_points):
		keys[gnumber].get_node("Sprite2D").get_node("Label").text = str(panel_points[gnumber])
		setup_panel(gnumber + 1)
	
	$UI/Score/Points.text = str(score)
	$UI/Score/Increment.text = str(score_inc)
	
	setup_loading_bar()
	activate_input(1)
	$UI/Guide.spawn_guide(gameguide[0], gamekeys[0])
	
func change_layout_text(layout):
	$UI/Tutorial/HowTo/WASD.text = Globals.input_layout_map[layout]["panel_mov"]
	$UI/Tutorial/HowTo/Space.text = Globals.input_layout_map[layout]["action"]
	$UI/Tutorial/HowTo/Arrowkeys.text = Globals.input_layout_map[layout]["game_mov"]
	$UI/Tutorial/Label/Label2.text = Globals.input_layout_map[layout]["enter"]
	$UI/GameOverMenu/MenueItems/Restart/Restart2.text = Globals.input_layout_map[layout]["restart"]
	$UI/GameOverMenu/MenueItems/Quit/Quit2.text = Globals.input_layout_map[layout]["quit"]
	$UI/PauseMenue/MenueItems/Restart/Restart2.text = Globals.input_layout_map[layout]["restart"]
	$UI/PauseMenue/MenueItems/Quit/Quit2.text = Globals.input_layout_map[layout]["quit"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/FPS.set_text("FPS " + str(Engine.get_frames_per_second()))
	update_loading_bar()
	update_signal()
	update_timer()
	launch_games()
	update_lifes()
	
	### Handles Input changes from keyboard to joystick and vice versa. 
	### This is a fucking mess. Controller Inputs are accompanied by keyboard inputs.
	### This most likely comes from Steam 
	var stop_input_change = false
	if Input.is_action_just_pressed("Jactivation") and not Input.is_action_just_pressed("kactivation") and input_layout != "joystick":
		change_layout_text("joystick")
		input_layout_old = "joystick"
		stop_input_change = true
		input_layout = "joystick"
	if Input.is_action_just_pressed("kactivation") and not Input.is_action_just_pressed("Jactivation") and input_layout != "keyboard":
		change_layout_text("keyboard")
		input_layout_old = input_layout
		input_layout = "keyboard"
		
	
	if Input.is_action_just_pressed("Enter") and practice == true:
		spawn_ready = []
		practice = false
		reset_all()
		await get_tree().create_timer(0.5).timeout
		launch_random_game()
		$UI/Tutorial.visible = false
		$UI/Score.visible = true
		
	if Input.is_action_just_pressed("W"):
		handle_controls("W")
		input_changed = true
	if Input.is_action_just_pressed("A"):
		handle_controls("A")
		input_changed = true
	if Input.is_action_just_pressed("S"):
		handle_controls("S")
		input_changed = true
	if Input.is_action_just_pressed("D"):
		handle_controls("D")
		input_changed = true
	if $UI/PauseMenue.menue_state == false and $UI/GameOverMenu.menue_state == false and input_changed == true:
		if practice == true:
			if games[current_input].active == false and games[current_input].spawn_ready == true:
				spawn_ready.append(current_input)
			
		activate_input(current_input + 1)
		$UI/Guide.spawn_guide(gameguide[current_input], gamekeys[current_input])
		input_changed = false
		

	
	# For Debugging
	if Input.is_action_just_pressed("newgame"):
		pass
		#stop_music()
		#$UI/GameOverMenu.trans_active = true
	if Input.is_action_just_pressed("Mute"):
		#stop_music()
		toggle_mute_all()
	
	if nlives < 1:
		stop_music()
		#await get_tree().create_timer(0.5).timeout
		nlives = 999999
		var ncats = int((strength-0.5) * 100)
		$UI/GameOverMenu.trans_active = true
		$UI/GameOverMenu/CatsSaved.ncats = ncats
		$UI/GameOverMenu/Points.npoints = score		
		
		practice = true
		$UI/Tutorial.visible = true
		$UI/Score.visible = false

func det_tut_spawn(spawns):
	var spawn_list = []
	for index in [0, 1, 4, 5]:
		if games[index].spawn_ready == true and index not in spawn_ready:
			spawn_list.append(index)
	return spawn_list

func on_game_win(panel):
	if practice == true:
		pass
		#spawn_ready.append(panel - 1)
		#spawn_panel_highlight(panel)
	else:
		await get_tree().create_timer(1.0).timeout
		launch_random_game()
		strength += 0.01
		score_inc += 1
		score += score_inc
		update_score()
		panel_points[panel-1] += 1
		keys[panel-1].get_node("Sprite2D").get_node("Label").text = str(panel_points[panel-1])
	
func on_game_lost(panel):
	if practice == true:
		pass
		#spawn_ready.append(panel - 1)
		#spawn_panel_highlight(panel)
	else:
		await get_tree().create_timer(1.0).timeout
		nlives -= 1
		score_inc = 0
		update_score()

func _on_spawn_timer_timeout():
	await get_tree().create_timer(1.0).timeout
	launch_random_game()
	setup_loading_bar()
func _on_menues_pause():
	pass

func _on_menues_reset():
	practice = true
	$UI/Tutorial.visible = true
	$UI/Score.visible = false
	reset_all()
	await get_tree().create_timer(0.5).timeout
	#launch_random_game()
	
func _on_tut_spawn_timer_timeout():
	pass

func _on_menue_enabler_timeout():
	menue_enabled = true
	
