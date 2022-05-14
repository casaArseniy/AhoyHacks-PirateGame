extends RigidBody2D

var screen_size # Size of the game window.
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 0, screen_size.y)

func _on_Area2D_body_entered(body):
	pass
#	if "EnemyShip" in body.name:
#		queue_free()
#	if "PirateShip" in body.name:
#		queue_free()
