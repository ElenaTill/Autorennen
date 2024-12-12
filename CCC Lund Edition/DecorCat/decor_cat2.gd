extends Node2D

#Current state of the cat
var cat_vel = 0
var cstate = "idle"

# Cat state transitions
# [Min time, maxtime, [[Possible state transitions, probability], ...]]
var states = {
	"idle": [1, 3, [["bark", 0.1], ["lick", 0.1], ["walk", 0.5],  ["sit", 0.5],  ["lay", 0.5],  ["stretch", 0.5]]], 
	"bark": [1, 2, [["itch", 0.1], ["lick", 0.3], ["lay", 0.5],  ["sit", 0.5]]],
	"walk": [3, 6, [["lay", 0.3], ["stretch", 0.3], ["running", 0.3],  ["idle", 0.3]]],
	"lay": [4, 8, [["sleep", 0.8], ["get_up", 1]]],
	"sleep": [4, 8, [["get_up", 1]]],
	"running": [1, 3, [["sit", 0.2], ["walk", 0.6], ["bark", 0.1]]],
	"lick": [1, 3, [["lick2", 0.8], ["walk", 0.5]]],
	"sit": [2, 4, [["lick", 0.5], ["walk", 0.5], ["itch", 0.5]]],
	"lick2": [1, 8, [["stretch", 0.5]]],
	"stretch": [2, 4, [["walk", 0.5]]],
	"get_up": [2, 3, [["bark", 0.1], ["lick", 0.1], ["walk", 0.5],  ["sit", 0.5],  ["lay", 0.5],  ["stretch", 0.5]]],
	"itch": [3, 6, [["stretch", 0.5]]]
	}
	
func set_cat_behaviour():
	if cstate == "walk":
		cat_vel = 10
		$Cat.flip_h = false
	elif cstate == "running":
		cat_vel = 40
		$Cat.flip_h = false
	else:
		cat_vel = 0
	
	#Randomly change Direction of cat movement
	if cstate == "walk" or cstate == "running":
		if randf() < 0.5:
			cat_vel *= -1
			$Cat.flip_h = not $Cat.flip_h

func change_state():
	cstate = determine_new_state()
	set_cat_behaviour()
	set_timer()
	$Cat.play(cstate)

func determine_new_state():
	var pos_states = states[cstate][2]
	for s in pos_states:
		if randf() < s[1]:
			return s[0]
	return "idle"

func set_timer():
	$statetimer.wait_time = randi_range(states[cstate][0], states[cstate][1])
	$statetimer.start()
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	change_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += cat_vel * delta
	if position.x < 100:
		position.x = 100
		cat_vel *= -1
		$Cat.flip_h = not $Cat.flip_h
	if position.x > 500:
		position.x = 500
		cat_vel *= -1
		$Cat.flip_h = not $Cat.flip_h

func _on_statetimer_timeout():
	change_state()
