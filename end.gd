extends Control

var time : int = 0

func _ready():
	$CenterContainer2.visible = false
	time = 30
	
	if gv.score > gv.high_score:
		gv.high_score = gv.score
		$new_high_score/AnimationPlayer.play("new_animation")
	
func _on_quit_fr_pressed():
	get_tree().quit()

func _on_continue_pressed():
	get_tree().change_scene_to_packed(preload("res://menu.tscn"))
	queue_free()

func _on_cont_1_pressed():
	get_tree().change_scene_to_packed(preload("res://menu.tscn"))
	queue_free()

func _on_quit_pressed():
	$CenterContainer2.visible = true
	$CenterContainer2/TextureRect/TextureRect/quit_fr/Timer.start()

func _on_timer_timeout():
	time -= 1
	$CenterContainer2/TextureRect/TextureRect/quit_fr/TextureRect/Label.text = str(time)
	
	if time <= 0:
		$CenterContainer2/TextureRect/TextureRect/quit_fr/TextureRect/Label.visible = false
		$CenterContainer2/TextureRect/TextureRect/quit_fr/TextureRect.visible = false
		$CenterContainer2/TextureRect/TextureRect/quit_fr.disabled = false
	else:
		$CenterContainer2/TextureRect/TextureRect/quit_fr/Timer.start()
