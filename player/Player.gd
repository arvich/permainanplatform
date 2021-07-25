extends KinematicBody2D

const GRAVITY = 15
const ACCELERATION = 100
var MAX_SPEED = 200
const UP = Vector2(0,-1)
var JUMP_HEIGHT = -450
var BULLET = preload("res://asset/bullet.tscn")
var motion = Vector2()
var touch_left = false
var touch_right = false
var touch_jump = false
var touch_shoot = false
var is_dead = false

const deadeffect = preload("res://player/DeadEffect.tscn")

func _physics_process(_delta):
	
	motion.y += GRAVITY
	var friction = false
	
	if is_dead == false:
		if Input.is_action_just_pressed("attack"):
			var bullet = BULLET.instance()
			if sign($Position2D.position.x) == 1:
				bullet.set_bullet_direction(1)
			else:
				bullet.set_bullet_direction(-1)
			get_parent().add_child(bullet)
			bullet.position = $Position2D.global_position
		
		if Input.is_action_pressed("ui_right") or touch_right:
			motion.x = min(motion.x+ACCELERATION, +MAX_SPEED)
			$chara.flip_h = false
			$chara.play("walk")
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left") or touch_left:
			motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
			$chara.flip_h = true
			$chara.play("walk")
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		else:
			$chara.play("idle")
			friction = true
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up") or touch_jump:
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x =lerp(motion.x, 0 ,0.2)
		else:
			if motion.y < 0:
				$chara.play("jump")
			else:
				$chara.play("fall")
			if friction == true:
				motion.x =lerp(motion.x, 0 ,0.2)
		motion = move_and_slide(motion, UP)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "enemy" in get_slide_collision(i).collider.name:
					dead()

func dead():
	is_dead = true
	motion = Vector2(0,0)
	$chara.play("dead")
	$CollisionShape2D.disabled = true
	$Timer.start()

func _on_left_pressed():
	touch_left = true
func _on_right_pressed():
	touch_right = true
func _on_jump_pressed():
	touch_jump = true

func _on_left_released():
	touch_left = false
func _on_right_released():
	touch_right = false
func _on_jump_released():
	touch_jump = false


func _on_Timer_timeout():
	get_tree().change_scene("res://scene/lv5.tscn")
