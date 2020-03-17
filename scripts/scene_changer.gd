extends CanvasLayer

export (PackedScene) var game_stage: PackedScene
export (PackedScene) var menu_stage: PackedScene

signal scene_changed(to_scene)

onready var animation_player: AnimationPlayer = $animation_player

func change_to_game_stage():
	change_scene_to(game_stage)

func change_to_menu_stage():
	change_scene_to(menu_stage)

func change_scene(to_scene: String, delay: float = 0.25):
	yield(get_tree().create_timer(delay), "timeout")
	var prev_layer = layer #save layer
	layer = 2
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(to_scene) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	layer = prev_layer #restore layer
	emit_signal("scene_changed", to_scene)

func change_scene_to(to_scene: PackedScene, delay: float = 0.25):
	yield(get_tree().create_timer(delay), "timeout")
	var prev_layer = layer #save layer
	layer = 2
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene_to(to_scene) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	layer = prev_layer #restore layer
	emit_signal("scene_changed", to_scene.resource_path)
