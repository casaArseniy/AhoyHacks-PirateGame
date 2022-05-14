extends AnimatedSprite

func _on_ShipExplode_animation_finished():
	queue_free()
