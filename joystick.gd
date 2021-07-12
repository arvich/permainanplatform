extends Node2D

onready var back = $back
onready var front = $front

export var min_hieght_of_joystick = 1300
export var ease_value = 0.25
export var joystick_range = 25
var screensize = Vector2.ZERO
var range_arr
var mouse_in = false
var mouse_pos

func _ready():
	screensize = get_viewport_rect().size
	range_arr = find_range()

func front_relative():
	mouse_pos = get_global_mouse_position()
	
	if Input.is_mouse_button_pressed(1) and mouse_in:
		front.global_position = lerp(front.global_position, mouse_pos, ease_value)
		front.global_position.x = clamp(front.global_position.x, range_arr[0], range_arr[1])
		front.global_position.y = clamp(front.global_position.y, range_arr[2], range_arr[3])
	else:
		front.global_position = lerp(front.global_position, back.global_position, ease_value)

func _process(delta):
	front_relative()

func find_range():
	var left_max_x = back.global_position.x - joystick_range
	var right_max_x = back.global_position.x + joystick_range
	var top_max_y = back.global_position.y - joystick_range
	var down_max_y = back.global_position.y + joystick_range
	
	var range_arr = [
		left_max_x,
		right_max_x,
		top_max_y,
		down_max_y
	]
	return range_arr

func _on_Area2D_mouse_entered():
	mouse_in = true
func _on_Area2D_mouse_exited():
	mouse_in = false
