extends Area2D

signal treasure_win

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Treasure_body_entered(body):
	if body.is_in_group("main_ship"):
		emit_signal("treasure_win")
		queue_free()
