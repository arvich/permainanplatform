extends AnimatedSprite

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	frame = 0
	play("default")
func _on_animation_finished():
	get_tree().reload_current_scene()
