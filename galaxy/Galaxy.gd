extends Node2D

var StarsArray = preload("res://stars.tscn")
var CameraScene = preload("res://camera_2d.tscn")
var camera
var star_offScreen = [] # storing all stars that was generated off screen

var angle = 0.0
var radius = 0.0
var spirl_tightness = 1.0
var spiral_rotation_speed = 0.1
var num_Stars = 25
var galaxy_radius = 1000
var screen_bounds = Vector2(2000,2000)


# Called when the node enters the scene tree for the first time.
func _ready():
	camera = CameraScene.instantiate()
	add_child(camera)
	#set this caera as current camera
	camera.is_current()
	
	randomize()
	var star_array = StarsArray.instantiate()
	
	add_child(star_array)
	
	var Stars = star_array.Stars
	_generategalaxy(Stars)
	_store_offscreen_stars()
	
func _generategalaxy(Stars):
	for i in range(num_Stars):
		var star_type = Stars[randi() % Stars.size()]
		var star_instance = star_type.instantiate()
		var buffer_space = 10.0 + i * .5 + star_instance.star_radius
		
		angle = i * 137.5 #golden angle for pleasing distribution
		radius = sqrt(i) * galaxy_radius / sqrt(num_Stars) + i * buffer_space
		
		var x = radius * cos(deg_to_rad(angle))
		var y = radius * sin(deg_to_rad(angle))
	
		star_instance.position = Vector2(x,y)
		
		star_offScreen.append(star_instance)
		add_child(star_instance)
		star_instance.hide()
		
func _store_offscreen_stars():
	for child in get_children():
		if child in StarsArray and !child.is_visible_in_tree():
			star_offScreen.append(child)
			
func _zoom_in_or_out(is_zoom_in):
	if is_zoom_in:
		_hide_distant_stars()
	else:
		_reveal_offscreen_stars()
		
func _hide_distant_stars():
	var camera_size = get_viewport_rect().size
	for star in get_children():
		if star in StarsArray and star.global_position.distance_to(camera.global_position) > camera_size.length() / 2:
			star.hide()
			star_offScreen.append(star) #add star to offscreen stars array
			
func _reveal_offscreen_stars():
	var camera_size = get_viewport_rect().size
	for star in star_offScreen:
		if star.global_position.distance_to(camera.global_position) <= camera_size.length() /2:
			star.show()
			star_offScreen.erase(star) #remove star from offscreen stars array
		
func _process(delta):
	_checkStars()
	
func _checkStars():
	for i in range(len(star_offScreen) -1, -1,1):
		var star_instance = star_offScreen[i]
		if star_instance.position.distance_to(Vector2.ZERO) > screen_bounds.length():
			star_offScreen.remove(i)
			star_instance.queue_free()
			
		while len(star_offScreen) < num_Stars:
			_generategalaxy(StarsArray.instantiate().Stars)
