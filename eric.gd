extends RigidBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_check_area : Area2D
var oob_check_area : Area2D
var jump_delay_timer : Timer
var rotation_target : float
var end_screen : bool = false

func _ready():
	jump_check_area = get_node("/root/main/jump_check")
	oob_check_area = get_node("/root/main/oob_check")
	oob_check_area.set_monitoring(true) 
	jump_delay_timer = $jump_delay
	gv.time = 0

func _physics_process(delta):
	if Input.is_action_just_pressed("db"):
		die()
	
	if gv.alive:
		if get_contact_count() > 0:
			die()

		gv.bg_speed = delta * remap(gv.time, 0, 600, 100, 1000)
		
		rotation_target = remap(get_linear_velocity().y, -500, 500, -30, 30)
		
		
		if Input.is_action_just_pressed("jump") and jump_check_area.overlaps_body(self) and jump_delay_timer.get_time_left() == 0:
			apply_impulse(Vector2(0, -500), Vector2(0, 0))
			jump_delay_timer.start()
		
		# fake damping
		if get_linear_velocity().y <= -500:
			apply_impulse(Vector2(0, remap(get_linear_velocity().y, -500, -1000, 0, 500)), Vector2(0, 0))
		if get_linear_velocity().y >= 500:
			apply_impulse(Vector2(0, remap(get_linear_velocity().y, 500, 1000, 0, -500)), Vector2(0, 0))
		
	else:
		gv.bg_speed = 0
		
	if oob_check_area.overlaps_body(self):
		if gv.alive:
			die()
		end()

func die():
	gv.alive = false
	$Sprite2D.frame = 1
	$death_timer.start()

func end():
	end_screen = true
	oob_check_area.set_monitoring(false) 
	get_tree().get_root().add_child(preload("res://end.tscn").instantiate())

func _on_timer_timeout():
	gv.time += 1

func _on_death_timer_timeout():
	if !end_screen:
		if ((get_linear_velocity() * Vector2(0.1, 0.1)).round() == (Vector2(0, 0))):
			end()
		else:
			$death_timer.start()
