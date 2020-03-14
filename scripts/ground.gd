#ground.gd
extends StaticBody2D

class_name Ground

var sprite: Sprite
var game_world: Node2D
var camera: Camera2D

func _ready():
	print(self, " ground_ready")
	game_world = node_accessor.game_world()
	camera = node_accessor.camera()
	sprite = get_node("sprite")
	print(self.name, " connect signal bird_grounded to ", game_world.name)
	connect("bird_grounded", game_world, "_on_bird_grounded")

func _process(delta):
	if is_camera_crossed_ground_length():
		queue_free()

func is_camera_crossed_ground_length():
	var cam_start_pos_x = camera.position.x
	var ground_end_pos_x = position.x + get_size().x
	return cam_start_pos_x > ground_end_pos_x

func get_size():
	return sprite.get_rect().size
