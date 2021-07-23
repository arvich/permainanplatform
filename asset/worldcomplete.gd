extends Area2D

export(String, FILE, "*.tscn") var next_world

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			yield(get_tree().create_timer(10),"timeout")
			get_tree().change_scene(next_world)
