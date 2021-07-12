extends KinematicBody2D

var speed = 140

var velocity = Vector2()
var stun = false
var hp = 5

func _process(delta):
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(Global.player.global_position)
	elif stun:
		velocity = lerp(velocity, Vector2(0,0), 0.3)
	
	global_position += velocity*speed*delta
	
	if hp <= 0:
		queue_free()
		if Global.camera != null:
			Global.camera.screen_shake(20, 0.1)


func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy_damage"):
		modulate = Color.white
		velocity = -velocity * 0.9
		stun = true
		hp -= 1
		$Stun_timer.start()
		area.get_parent().queue_free()


func _on_Timer_timeout():
	modulate = Color("c5dfb6")
	stun = false
