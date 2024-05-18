extends Node2D

var upper_min : int = 0 # 0
var upper_max : int = 0 # 140
var lower_min : int = 0 # 650
var lower_max : int = 0 # 800

var upper : AnimatableBody2D
var lower : AnimatableBody2D
var point_check : Area2D

var point_check_posref : float

func _ready():
	upper_min = remap(gv.time, 0, 600, 0, 130)
	upper_max = remap(gv.time, 0, 600, 50, 140)
	lower_min = remap(gv.time, 0, 600, 750, 650)
	lower_max = remap(gv.time, 0, 600, 800, 660)
	
	upper = $upper
	lower = $lower
	
	upper.position.y = randi_range(upper_min, upper_max)
	lower.position.y = randi_range(lower_min, lower_max)
	
	point_check = $point_check
	point_check_posref = $lower/lower_posref.global_position.y - ($upper/upper_posref.global_position.y / 2)
	print(point_check_posref)
	point_check.position.y = point_check_posref
	point_check.get_child(0).get_shape().set_size(Vector2(50, point_check_posref))

	position.x = 600

func _physics_process(delta):
	position.x -= gv.bg_speed
	
	if position.x < -125:
		queue_free()

func _on_point_check_body_entered(body):
	if body.is_in_group("player"):
		pass
