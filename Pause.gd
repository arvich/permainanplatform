extends CanvasLayer

func _ready():
	#set_visible(false)
	
	pass
func _Input(event):
	
	if event.is_action_pressed("ui_cancel"):
	#	set_visible(!get_tree().pause)
		get_tree().pause = !get_tree().pause
