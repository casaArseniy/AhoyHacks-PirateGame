extends KinematicBody2D

	
var motion = Vector2()
var elapsed = 20.0
var weight = 0.1
var cannonball = preload("res://Cannonball.tscn")
var center=Vector2.ZERO
var player_line=Vector2.ZERO
var ship_line=Vector2.ZERO

signal enemy_blown_up

var shoot=false

export var cannonball_speed= 800
var explosion=preload("res://ShipExplode.tscn")
onready var timer = get_node("Timer")

func _ready():
	timer.start()

func _physics_process(delta):
	var Player = get_parent().get_node("PirateShip")
	position+=(Player.position - position)/300
	look_at(Player.position)
	move_and_collide(motion)
	
	if $CannonCone.overlaps_body(Player) and shoot==true:
		var cannonball_instance=cannonball.instance()
		cannonball_instance.global_position=$EnemyNoseCannon.get_global_position()
		cannonball_instance.rotation_degrees=rotation_degrees
		center = $Center.get_global_position()
		player_line=(cannonball_instance.position-center).normalized()*400
		cannonball_instance.apply_impulse(Vector2(), player_line)
		cannonball_instance.add_to_group("enemy_ball")
		get_tree().get_root().add_child(cannonball_instance)
		shoot=false



func _on_Area2D_body_entered(body):
	if body.is_in_group("pirate_ball"):
		emit_signal("enemy_blown_up")
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		body.queue_free()
		queue_free()



func _on_Timer_timeout():
	shoot=true
