extends AnimatedSprite

func _on_ExplosionAnimated_animation_finished():
	queue_free()
