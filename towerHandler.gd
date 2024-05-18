extends Node2D

@onready var th_timer : Timer = $Timer
var th_timer_min : float 
var th_timer_max : float

func _on_timer_timeout():
	self.add_child(preload("res://tower.tscn").instantiate())
	th_timer_min = remap(gv.time, 0, 600, 4, 2)
	th_timer_max = remap(gv.time, 0, 600, 8, 4)
	th_timer.start(randf_range(1, 3))
