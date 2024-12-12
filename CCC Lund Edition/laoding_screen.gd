extends Node2D

func _ready():
	ResourceLoader.load_threaded_request(Globals.next_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var progress = []
	ResourceLoader.load_threaded_get_status(Globals.next_scene, progress)
	$LaodingLabel/Label.text = str(int(progress[0]*100)) + "%"
	
	if progress[0] == 1:
		var maingame_scene = ResourceLoader.load_threaded_get(Globals.next_scene)
		get_tree().change_scene_to_packed(maingame_scene)
		$BG.visible = false
		$LaodingLabel.visible = false
