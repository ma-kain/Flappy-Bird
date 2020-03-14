extends CanvasLayer

var instruction_button: TextureButton

func _ready():
	$gameover_panel.hide()
	$instruction_button.grab_focus()
	$score_label.text = str(0)

func update_live_score(score):
	$score_label.text = str(score)

func show_gameover_panel():
	$gameover_panel.animate_gameover_panel()
	$score_label.hide()

func _on_instruction_button_pressed():
	var bird = node_accessor.bird()
	
	if bird:
		bird.set_state(bird.STATE_FLAPPING())
		var pipe_spawner = node_accessor.pipe_spawner()
		if pipe_spawner:
			pipe_spawner.start()
	$instruction_button.hide()

func _on_play_button_pressed():
	$gameover_panel/v_container/h_container/play_button.disabled = true
	var replay_scene = "res://scenes/game_world.tscn"
	print("emit signal change_scene to ", replay_scene)
	scene_changer.change_scene_to(replay_scene)

