extends Node2D

var mode = 1

func init():
	$"../CanvasGroup".visible = false
	$"../Tutorial".visible = false
	$Mask1.visible = true
	$Mask2.visible = true
	$Mask3.visible = false
	$Mask4.visible = false
	$WASD.visible = false

	for N in $"../CanvasGroup".get_children():
		N.visible = false

func finished():
	
	$"../CanvasGroup".visible = true
	$"../Tutorial".visible = true
	for k in $"../..".keys:
		k.visible = true
	$"../CanvasGroup/SelectEffect".visible = true
	$"../..".tutorial = false
	$"../..".practice = true
	$".".visible = false
	$"../../MenueEnabler".start()
	$"../../GameLogic/SpawnTimer".wait_time = 60
	$"../../GameLogic/SpawnTimer".stop()
	set_process(false)

# Called when the node enters the scene tree for the first time.
func _ready():
	init()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Menue"):
		finished()
	if Input.is_action_just_pressed("Enter"):
		if mode == 1:
			$"../..".spawn_ready.append(0)	
		if mode == 2:
			pass
		if mode == 3:
			$"../../GameLogic/SpawnTimer".wait_time = 15
			$"../../GameLogic/SpawnTimer".start()
		mode += 1
		
		if mode == 1:
			$Description.text = "In Catastrophic Cat Command you need to complete cat-themed games to succeed"
			$Sprite1.visible = true
			$TArrow.visible = false

		if mode == 2:
			$Description.text = "In this game you need to avoid the Asteroid. The controls are always shown below the main panel."
			$TArrow.visible = true
			$Sprite1.visible = false
			$Sprite2.visible = true
			$TArrow.rotation = PI
			$TArrow.position = Vector2(780, 550)
		
		if mode == 3:
			$Description.text = "There are different games active at different locations. Navigate to the active game with"
			$TArrow.visible = false
			$Mask1.visible = false
			$Mask2.visible = false
			$Mask3.visible = true
			$Mask4.visible = true
			$Sprite2.visible = false
			$Sprite3.visible = true
			$WASD.visible = true
			
			$"../CanvasGroup".visible = true
			$"../CanvasGroup/Key1".visible = true
			$"../CanvasGroup/Key2".visible = true
			$"../CanvasGroup/Key5".visible = true
			$"../CanvasGroup/Key6".visible = true
			$"../CanvasGroup/SelectEffect".visible = true
		
	if mode == 4:
		$WASD.visible = false
		$Description.text = "Every time this timer gets to zero, a new game gets activated. You have to play this game simultaneously!"
		$TArrow.rotation = 0
		$TArrow.position = Vector2(730, 480)
		$TArrow.visible = true
	
	if mode == 5:
		$Sprite3.visible = false
		$Sprite4.visible = true
		$Description.text = "After this tutorial you start in Pricatice Mode. There you can try out all games without any stress!"
		$TArrow.visible = false
	
	if mode == 6:
		$Sprite4.visible = false
		$Sprite5.visible = true
		$Description.text = "In Practice Mode: Once you hit [Enter], you start a real run. Try to complete as many games as you can to get a spot on the leaderboard!"
		$TArrow.visible = false
	
	if mode == 7:
		finished()
		
