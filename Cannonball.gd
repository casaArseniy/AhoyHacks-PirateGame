extends RigidBody2D

var velocity=Vector2.ZERO

func _on_Area2D_body_entered(body):
	if body is TileMap:
		queue_free()
