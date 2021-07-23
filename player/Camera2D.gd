extends Camera2D

var screen_shake = false
var shake_intensity = 0

func _process(delta):
	zoom = lerp(zoom, Vector2(1,1), 0.3)
	if screen_shake == true:
		global_position += Vector2(rand_range(-shake_intensity, shake_intensity), rand_range(-shake_intensity, shake_intensity)) *delta

func screen_shake(intensity, time):
	zoom = Vector2(1,1) - Vector2(intensity * 0.002, intensity * 0.002)
	shake_intensity = intensity
	$screen_shake.wait_time = time
	$screen_shake.start()
	screen_shake = true

func _on_screen_shake_timeout():
	screen_shake = false
