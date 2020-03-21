extends RigidBody2D

signal bird_grounded

var state
onready var animation_player: AnimationPlayer = $animation_player

const BIRD_LAYER = 0
const speed = 50

func STATE_FLYING():
	return FlyingState.new(self)

func STATE_FLAPPING():
	return FlappingState.new(self)

func STATE_HIT():
	return HitState.new(self)

func STATE_GROUNDED():
	return GroundedState.new(self)

func _ready():
	print(self, 'bird_ready')
	set_process_input(true)
	state = FlyingState.new(self)

func _process(delta):
	state.update(delta)

func _input(event):
	state.input(event)

func _on_bird_body_entered(body: StaticBody2D):
	if body is Pipe:
		set_state(STATE_HIT())
		set_collision_layer_bit(BIRD_LAYER, false)
	elif body is Ground:
		set_state(STATE_GROUNDED())
		emit_signal("bird_grounded")

func set_state(new_state):
	state.exit()
	state = new_state

func get_state():
	return state

class FlyingState:
	var bird
	var pre_gravity_scale
	func _init(bird):
		self.bird = bird
		bird.animation_player.play("flying")
		bird.linear_velocity = Vector2(bird.speed, bird.linear_velocity.y)
		pre_gravity_scale = bird.gravity_scale
		bird.gravity_scale = 0.0

	func update(delta):
		pass
	func input(event):
		pass
	func exit():
		bird.gravity_scale = pre_gravity_scale
		pass

class FlappingState:
	var bird
	func _init(bird):
		self.bird = bird
		bird.linear_velocity = Vector2(bird.speed, bird.linear_velocity.y)
		
	func update(delta):
		if bird.rotation_degrees < -30:
			bird.rotation_degrees = -30
			bird.angular_velocity = 0
			
		if bird.linear_velocity.y > 0:
			bird.angular_velocity = 1.5

	func flap():
		bird.linear_velocity = Vector2(bird.linear_velocity.x, -150)
		bird.angular_velocity = -3
		bird.animation_player.play("flap")
		audio_player.get_node("sfx_wing").play()

	func input(event):
		if event.is_action_pressed("flap") || (event is InputEventScreenTouch and event.is_pressed()):
			flap()

	func exit():
		pass

class HitState:
	var bird
	func _init(bird):
		self.bird = bird
		#bird.animation_player.play("hit")
		bird.linear_velocity = Vector2.ZERO
		bird.angular_velocity = 2
		audio_player.get_node("sfx_die").play()

	func update(delta):
		pass
	func input(event):
		pass
	func exit():
		pass

class GroundedState:
	var bird
	func _init(bird):
		self.bird = bird
		audio_player.get_node("sfx_hit").play()
		#bird.animation_player.play("grounded")

	func update(delta):
		pass
	func input(event):
		pass
	func exit():
		pass

