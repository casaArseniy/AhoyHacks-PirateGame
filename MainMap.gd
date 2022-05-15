extends Node2D


var rng = RandomNumberGenerator.new()
var target = preload("res://EnemyShip.tscn")
var treasure = preload("res://Treasure.tscn")

var reload=5
var health=3
var treasure_found=false

var time=30

# Called when the node enters the scene tree for the first time.
func new_game():
	$HUD.update_ship_number(reload)
	$HUD.update_health(3)
	$HUD.update_timer(time)
	$HUD.show_message("Get Ready")
	
	var targets=0
	while targets<5:
		rng.randomize()
		var rndX = rng.randi_range(0, 15)
		var rndY = rng.randi_range(0, 15)
		if $WorldMap.get_cell(rndX, rndY)==1:
			var target_instance=target.instance()
			var tile_center_pos = $WorldMap.map_to_world(Vector2(rndX,rndY)) + $WorldMap.cell_size / 2
			target_instance.position=Vector2(tile_center_pos[0], tile_center_pos[1])
			target_instance.rotation_degrees=rotation_degrees
			add_child(target_instance)
			target_instance.connect("enemy_blown_up", self, "enemy_blown_up_received")
			targets+=1
	
	rng.randomize()
	var rndX = rng.randi_range(0, 15)
	var rndY = rng.randi_range(0, 15)
	var cell = $WorldMap.get_cell(rndX, rndY)
	while cell!=1:
		rng.randomize()
		rndX = rng.randi_range(0, 15)
		rndY = rng.randi_range(0, 15)
		cell = $WorldMap.get_cell(rndX, rndY)
	print(cell)
	var treasure_instance=treasure.instance()
	var tile_center_pos = $WorldMap.map_to_world(Vector2(rndX,rndY)) + $WorldMap.cell_size / 2
	treasure_instance.position=Vector2(tile_center_pos[0], tile_center_pos[1])
	treasure_instance.rotation_degrees=rotation_degrees
	add_child(treasure_instance)
	treasure_instance.connect("treasure_win", self, "treasure_found_func")
	
	$GameTimer.start()

func treasure_found_func():
	treasure_found=true

func enemy_blown_up_received():
	reload-=1
	$HUD.update_ship_number(reload)

func pirate_got_shot():
	if health>0:
		health-=1
	else:
		health=0
	$HUD.update_health(health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health==0 or time==0:
		$HUD.show_game_over()
		yield(get_tree().create_timer(2), "timeout")
		get_tree().reload_current_scene()
	if reload==0 and treasure_found==true:
		$HUD.show_game_won()
		yield(get_tree().create_timer(2), "timeout")
		get_tree().reload_current_scene()

func _on_HUD_start_game():
	$HUD.update_ship_number(reload)
	$HUD.update_health(3)
	$HUD.show_message("Get Ready")


func _on_GameTimer_timeout():
	if time>0:
		time-=1
	else:
		time=0
	$HUD.update_timer(time)
