extends Area2D

export(String, FILE, "*.tscn") var next_world
export var timer = 5

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			yield(get_tree().create_timer(timer),"timeout")
			get_tree().change_scene(next_world)
