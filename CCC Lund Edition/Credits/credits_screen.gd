extends Node2D

#var creditsentry : PackedScene = preload("res://Credits/credits.gd")

@onready var creditsentry = preload("res://Credits/credits.tscn")

var current_credit = 0
var credits_entry = [	["Main Developement", "Christian Drews"], 
						["Music : GameOver", "Jakob Lange"],
						["Art : Decorative Cats", "LuizMelo"],
						["Cat Theme Concept:", "Yara Meier"],
						["Cat Theme Concept:", "Kimberly Saar"],
						["Cat Theme Concept:", "Carlotta Lüth"]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_credit == len(credits_entry):
		current_credit = 0

func spawn_next():
	var C = creditsentry.instantiate()
	add_child(C)
	C.position.y = 50
	C.get_node("Title").text = credits_entry[current_credit][0]
	C.get_node("Title").get_node("Name").text = credits_entry[current_credit][1]
	current_credit += 1

func _on_timer_timeout():
	spawn_next()
	
