extends Camera2D

var min_zoom = .5
var max_zoom = 1.5
var zoom_speed = .1

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom.x = clamp(zoom.x - zoom_speed, min_zoom,max_zoom)
			zoom.y = clamp(zoom.y - zoom_speed, min_zoom,max_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom.x = clamp(zoom.x + zoom_speed, min_zoom,max_zoom)
			zoom.y = clamp(zoom.y + zoom_speed, min_zoom,max_zoom)
