extends Node2D


var rng = RandomNumberGenerator.new()
var target = preload("res://EnemyShip.tscn")

var reload=0
# Called when the node enters the scene tree for the first time.
func _ready():
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

func enemy_blown_up_received():
	reload+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if reload==5:
		get_tree().reload_current_scene()
