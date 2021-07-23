extends KinematicBody2D

var speed = 50
var velocity = Vector2()
export var direction = -1
export var detects_cliffs = true

func _ready():
	if direction == 1:
		$unnamed.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs
	

func _physics_process(delta):
	
	if is_on_wall() or not $floor_checker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1
		$unnamed.flip_h = not $unnamed.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y += 20
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_body_entered(body):
	#$unnamed.play("")
	speed = 0
	set_collision_layer_bit(1,false)
	set_collision_mask_bit(0,false)
	$top_checker.set_collision_layer_bit(1,false)
	$top_checker.set_collision_mask_bit(0,false)
	$side_checker.set_collision_layer_bit(1,false)
	$side_checker.set_collision_mask_bit(0,false)

func _on_side_checker_body_entered(body):
	body.ouch()
	
