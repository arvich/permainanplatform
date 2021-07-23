extends KinematicBody2D

const GRAVITY = 15
const ACCELERATION = 100
var MAX_SPEED = 200
const UP = Vector2(0,-1)
const JUMP_HEIGHT = -450
var motion = Vector2()
var velocity:Vector2 = Vector2.ZERO
var bullet = preload("res://asset/bullet1.tscn")
var can_shoot = true
var is_dead = false
var touch_left = false
var touch_right = false
var touch_jump = false
var touch_shoot = false
onready var joystick = get_parent().get_node("Hud/Node2D/touchscreenjoystick")

const deadeffect = preload("res://player/DeadEffect.tscn")

func _physics_process(_delta):
	
	if is_dead == false:
		global_position += MAX_SPEED * velocity
	
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right") or touch_right:
		motion.x = min(motion.x+ACCELERATION, +MAX_SPEED)
		$CollisionShape2D/chara.flip_h = false
		$CollisionShape2D/chara.play("walk")
	elif Input.is_action_pressed("ui_left") or touch_left:
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$CollisionShape2D/chara.flip_h = true
		$CollisionShape2D/chara.play("walk")
	else:
		$CollisionShape2D/chara.play("idle")
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up") or touch_jump:
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x =lerp(motion.x, 0 ,0.2)
	else:
		if motion.y < 0:
			$CollisionShape2D/chara.play("jump")
		else:
			$CollisionShape2D/chara.play("fall")
		if friction == true:
			motion.x =lerp(motion.x, 0 ,0.2)
	motion = move_and_slide(motion, UP)
	pass

func ouch():
	MAX_SPEED = 0
	visible = false
	var deadEffect = deadeffect.instance()
	get_parent().add_child(deadEffect)
	deadEffect.global_position = global_position
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
