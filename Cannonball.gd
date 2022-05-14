extends RigidBody2D

var velocity=Vector2.ZERO
var explosion=preload("res://ExplosionAnimated.tscn")

func _on_Area2D_body_entered(body):
	if body is TileMap:
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()
