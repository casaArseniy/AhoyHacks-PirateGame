extends TileMap


var rng = RandomNumberGenerator.new()
var reload=0
var width = 15
var height = 15
var target = preload("res://EnemyShip.tscn")


func binary_maze():
	rng.randomize()
	var my_random_number = 0
	
	var i=1
	var j=1
	while i<width-1:
		while j<height-1:
			my_random_number = rng.randi_range(0, 1)
			if my_random_number==0:
				set_cell(i+1,j, 1)
			else:
				set_cell(i,j+1, 1)
			j+=1
		i+=1
		j=1
# Called when the node enters the scene tree for the first time.
func _ready():
	var screenSize = get_viewport().get_visible_rect().size
	binary_maze()
#	var targets=0
#	while targets<5:
#		rng.randomize()
#		var rndX = rng.randi_range(0, 15)
#		var rndY = rng.randi_range(0, 15)
#		if get_cell(rndX, rndY)==INVALID_CELL:
#			var target_instance=target.instance()
#			var tile_center_pos = map_to_world(Vector2(rndX,rndY)) + cell_size / 2
#			target_instance.position=Vector2(tile_center_pos[0], tile_center_pos[1])
#			target_instance.rotation_degrees=rotation_degrees
#			get_tree().get_root().add_child(target_instance)
#			targets+=1

func _input(event: InputEvent):
	if event.is_action_pressed("reload_map"):
		get_tree().call_group("enemy_ship", "queue_free")
		get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
