extends Node

const GROUND_WIDTH = 168
export (PackedScene) var ground_scene
var ground

func _ready():
	print(self, 'ground_spawner_ready')
	spawn_ground(-70, 256)
	spawn_ground(ground.position.x + GROUND_WIDTH, ground.position.y)	

func spawn_ground(var x, var y):
	ground = ground_scene.instance()
	print(ground.name, " connect signal tree_exited to ", self.name)
	ground.connect("tree_exited", self, "_on_ground_tree_exited")
	ground.position = Vector2(x,y)
	call_deferred("add_child", ground)

func _on_ground_tree_exited():
	spawn_ground(ground.position.x + GROUND_WIDTH, ground.position.y)
