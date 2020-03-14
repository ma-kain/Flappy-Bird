extends CanvasLayer

signal scene_changed()

onready var animation_player: AnimationPlayer = $animation_player

func change_scene_to(to_scene: String, delay: float = 0.25):
	yield(get_tree().create_timer(delay), "timeout")
	var prev_layer = layer #save layer
	layer = 2
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(to_scene) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	layer = prev_layer #restore layer
	emit_signal("scene_changed")
