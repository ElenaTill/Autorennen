extends Node

# Steam variables

var loading_screen = preload("res://laoding_screen.tscn")
var next_scene : String = "res://MainGame.tscn"
var score_list = []

### Keyboard Layout
var input_layout_map = {"joystick": 
		{"panel_mov": "Right Stick",
		"action": "Button A",
		"game_mov": "Left Stick",
		"enter": "Button X",
		"restart": "Button B",
		"quit": "Button Y"},
	"keyboard":
		{"panel_mov": "[W A S D]",
		"action": "[Space]",
		"game_mov": "Arrow Keys", 
		"enter": "[Enter]",
		"restart": "[R]",
		"quit": "[Q]"}}
