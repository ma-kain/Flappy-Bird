#pipe.gd
extends StaticBody2D

class_name Pipe

signal score_checkpoint_crossed

const PIPE_WIDTH = 26

var game_world: Node2D
var camera: Camera2D

func _ready():
	print(self, " pipe_ready")
	game_world = node_accessor.game_world()
	camera = node_accessor.camera()
	print(self.name, " connect signal score_checkpoint_crossed to ", game_world.name)
	connect("score_checkpoint_crossed", game_world, "_on_pipe_score_checkpoint_crossed")

func _process(delta):
	if is_camera_crossed_pipe_length():
		queue_free()

func is_camera_crossed_pipe_length():
	var cam_start_pos_x = camera.position.x
	var pipe_end_pos_x = position.x + PIPE_WIDTH/2.0
	return cam_start_pos_x > pipe_end_pos_x


func _on_score_checkpoint_body_exited(body):
	emit_signal("score_checkpoint_crossed")

