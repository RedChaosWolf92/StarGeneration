extends StaticBody2D

var star_color = Color.RED
var star_size = randf_range(1.2, 10)
var star_radius = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_RedStar()
	
func generate_RedStar():
	self.modulate = star_color
	$Red.scale = Vector2(star_size,star_size)
	
	var x = randf_range(200,1600)
	var y = randf_range(200,1000)
	
	star_radius = star_size / 2
	
	self.position = Vector2(x,y)
	
