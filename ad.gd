@tool
extends Control

var anchor_presets : Array = [[0.15, 0, 0.85, 0.13], [0.15, 0.87, 0.85, 1], [0, 0.2, 0.2, 0.8], [0.8, 0.2, 1, 0.8]]
var image_type_directories : Array = ["res://ad_images/horizontal/", "res://ad_images/vertical/", "res://ad_images/horizontal_large/"]
var urls : Array = ["https://www.sbgom.com", "https://geo.gringpartei.ch"]
var image_types : Array

@export_enum("Horizontal Up", "Horizontal Down", "Vertical Left", "Vertical Right") var preset : int :
	set(value):
		preset = value
		for i in anchor_presets[value].size():
			set_anchor(i, anchor_presets[value][i], true)
			
@export_enum("Horizontal", "Vertical", "Horizontal Large") var image_type : int :
	set(value):
		image_type = value
		set_random()

@export var import_images : bool :
	set(value):
		import()
		import_images = false

@export var randomize_image : bool :
	set(value):
		set_random()
		randomize_image = false

func set_random():
	var texturerect : TextureRect = get_child(0)
	get_child(1).set_uri(urls.pick_random())

	if image_types[image_type].is_empty():
		import()
	
	texturerect.set_texture(image_types[image_type].pick_random())

func import():
	image_types.clear()
	for i in image_type_directories.size():
		image_types.append([])
		var current_files = DirAccess.get_files_at(image_type_directories[i])
		for j in current_files.size():
			if ["png", "jpg", "jpeg"].has(current_files[j].get_extension()):
				print(current_files[j] + str(i))
				image_types[i].append(load(image_type_directories[i] + current_files[j]))

func _ready():
	if not Engine.is_editor_hint():
		import()
		set_random()
