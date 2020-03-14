extends Camera2D

func _ready():
	print(self, 'camera_ready')

func _process(delta):
	self.position.x = node_accessor.bird().position.x-72
