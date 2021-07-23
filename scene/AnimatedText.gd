extends Node2D

func _ready():
	$Area2D.connect("body_entered", self, '_play_animation')
	
func _play_animation(body):
	$Area2D.disconnect("body_entered", self, '_play_animation')
	$AnimationPlayer.play("New Anim")
