extends TextureRect

export(String) var scene_to_load

func get_click():
	get_tree().change_scene("res://map/world3.tscn")
