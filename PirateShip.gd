extends KinematicBody2D

export var speed = 100 # How fast the player will move (pixels/sec).
export var cannonball_speed= 800
var screen_size # Size of the game window.
var cannonball = preload("res://Cannonball.tscn")
var explosion=preload("res://ShipExplode.tscn")
var target = Vector2.ZERO
var velocity = Vector2.ZERO
var cannonball_velocity=Vector2.ZERO
var center=Vector2.ZERO

var anchor=false

var Health=3

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Health==0:
		get_tree().reload_current_scene()
	
	target=get_global_mouse_position()
	velocity=global_position.direction_to(target)*speed
	look_at(get_global_mouse_position())
	if anchor==false:
		move_and_slide(velocity)
	
	
	if Input.is_action_pressed("anchor"):
		if anchor==true:
			anchor=false
		else:
			anchor=true
	
	if Input.is_action_just_pressed("nose_shoot"):
		var cannonball_instance=cannonball.instance()
		cannonball_instance.position=$NoseCannon.get_global_position()
		cannonball_instance.rotation_degrees=rotation_degrees
		cannonball_instance.apply_impulse(Vector2(), Vector2(cannonball_speed,0).rotated(rotation))
		cannonball_instance.add_to_group("pirate_ball")
		get_tree().get_root().add_child(cannonball_instance)
	if Input.is_action_just_pressed("left_shoot"):
		var cannonball_instance=cannonball.instance()
		center = $Center.get_global_position()
		cannonball_instance.position=$LeftCannon.get_global_position()
		cannonball_instance.rotation_degrees=rotation_degrees
		cannonball_velocity=(cannonball_instance.position-center).normalized()*800
		cannonball_instance.apply_impulse(Vector2(),cannonball_velocity)
		cannonball_instance.add_to_group("pirate_ball")
		get_tree().get_root().add_child(cannonball_instance)
	if Input.is_action_just_pressed("right_shoot"):
		var cannonball_instance=cannonball.instance()
		center = $Center.get_global_position()
		cannonball_instance.position=$RightCannon.get_global_position()
		cannonball_instance.rotation_degrees=rotation_degrees
		cannonball_velocity=(cannonball_instance.position-center).normalized()*800
		cannonball_instance.apply_impulse(Vector2(),cannonball_velocity)
		cannonball_instance.add_to_group("pirate_ball")
		get_tree().get_root().add_child(cannonball_instance)

	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy_ball"):
		body.queue_free()
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		Health-=1
		
