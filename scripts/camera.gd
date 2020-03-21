extends Camera2D

const duration = 0.2
const magnitude = 3.0

func _ready():
	print(self, 'camera_ready')
	node_accessor.bird().connect("bird_grounded", self, "_on_bird_grounded")

func _on_bird_grounded():
	shake()

func _process(delta):
	self.position.x = node_accessor.bird().position.x-72

func shake():
	var initial_pos = position
	var timer: SceneTreeTimer = get_tree().create_timer(duration)
	
	while timer.time_left > 0:
		yield(get_tree(), "idle_frame")
		var x = rand_range(-magnitude, magnitude)
		var y = rand_range(-magnitude, magnitude)
		offset = Vector2(x,y)
		
	position = initial_pos
