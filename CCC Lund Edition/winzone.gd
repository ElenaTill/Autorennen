extends Area2D

signal win

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.set_deferred("disabled", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	win.emit()
	#$CollisionShape2D.set_deferred("disabled", true)
