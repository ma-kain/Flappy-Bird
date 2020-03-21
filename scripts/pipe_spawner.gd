extends Node

const GROUND_HEIGHT = 56
const PIPE_WIDTH    = 26
const OFFSET_X      = 65
const OFFSET_Y      = 55
const AMOUNT_TO_FILL_VIEW = 3
const VIEWPORT_WIDTH = 144
const VIEWPORT_HEIGHT = 256

export (PackedScene) var pipe_scene

var pipe

func _ready():
	pass

func start():
	print(self, 'pipe_spawner_ready')
	var camera = node_accessor.camera()
	
	var init_pos = Vector2()
	init_pos.x = VIEWPORT_WIDTH + camera.position.x
	init_pos.y = (VIEWPORT_HEIGHT-GROUND_HEIGHT)/2.0
	
	spawn_pipe(init_pos.x, init_pos.y)
	spawn_pipe(pipe.position.x + gap_between_two_pipe_centers(), 
		vertical_distance_between_pipe_center_and_viewport_center())

func spawn_pipe(var x, var y):
	pipe = pipe_scene.instance()
	print(pipe.name, " connect signal tree_exited to ", self.name)
	pipe.connect("tree_exited", self, "_on_pipe_tree_exited")
	pipe.position = Vector2(x,y)
	call_deferred("add_child", pipe)

func _on_pipe_tree_exited():
	spawn_pipe(pipe.position.x + gap_between_two_pipe_centers(), 
		vertical_distance_between_pipe_center_and_viewport_center())

func gap_between_two_pipe_centers():
	return PIPE_WIDTH/2.0 + OFFSET_X + PIPE_WIDTH/2.0

func vertical_distance_between_pipe_center_and_viewport_center():
	randomize()
	var viewport_vertical_center = (VIEWPORT_HEIGHT - GROUND_HEIGHT)/2.0
	return rand_range(viewport_vertical_center - OFFSET_Y, viewport_vertical_center + OFFSET_Y)
	
