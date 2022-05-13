extends KinematicBody2D

	
var motion = Vector2()
var elapsed = 20.0
var weight = 0.1
var cannonball = preload("res://Cannonball.tscn")
export var cannonball_speed= 800

func _physics_process(delta):
	var Player = get_parent().get_node("PirateShip")
	var Bot = get_parent().get_node("EnemyShip")
	position+=(Player.position - position)/300
	look_at(Player.position)
	var cannonball_instance=cannonball.instance()
	cannonball_instance.position=$NoseCannon.get_global_position()
	cannonball_instance.rotation_degrees=rotation_degrees
	cannonball_instance.apply_impulse(Vector2(), Player.position.normalized()*800)
	cannonball_instance.add_to_group("enemy_ball")
	get_tree().get_root().add_child(cannonball_instance)

	
	
#
	move_and_collide(motion)
#	var min_angle = deg2rad(get_angle_to(Bot.position))
#	var max_angle = deg2rad(get_angle_to(Player.position))
#	rotation = lerp_angle(min_angle, max_angle, elapsed)
#	elapsed += delta



func _on_Area2D_body_entered(body):
#	if "Cannonball" in body.name:
#		queue_free()
	if body.is_in_group("enemy_ball"):
		pass
	elif body.is_in_group("pirate_ball"):
		queue_free()
