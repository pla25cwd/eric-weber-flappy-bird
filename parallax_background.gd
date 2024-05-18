extends ParallaxBackground

var p_offset : float

func _physics_process(delta):
	if p_offset >= 80000:
		p_offset = 0
	p_offset -= gv.bg_speed
	set_scroll_offset(Vector2(p_offset, 0))
	#debug
	$Label.text = str(gv.bg_speed)
