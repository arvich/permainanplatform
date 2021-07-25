extends Area2D

const SPEED = 1000
var velocity = Vector2()
var direction = 1

func _ready():
	pass

func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_bullet_body_entered(body):
	if "enemy" in body.name:
		body.dead()
	queue_free()
