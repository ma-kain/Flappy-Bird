#ground.gd
extends StaticBody2D

class_name Ground

var sprite: Sprite
var game_world: Node2D
var camera: Camera2D

func _ready():
	print(self, " ground_ready")
	camera = node_accessor.camera()
	sprite = get_node("sprite")

func _process(delta):
	if is_camera_crossed_ground_length():
		queue_free()

func is_camera_crossed_ground_length():
	var cam_start_pos_x = camera.position.x
	var ground_end_pos_x = position.x + get_size().x
	return cam_start_pos_x > ground_end_pos_x

func get_size():
	return sprite.get_rect().size
