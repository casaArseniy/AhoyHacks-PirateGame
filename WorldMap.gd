extends TileMap


var rng = RandomNumberGenerator.new()
var reload=0
var width = 15
var height = 15



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

func _input(event: InputEvent):
	if event.is_action_pressed("reload_map"):
		get_tree().call_group("enemy_ship", "queue_free")
		get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
