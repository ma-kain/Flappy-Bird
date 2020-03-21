#game_world.gd
extends Node2D

var current_score = 0
var is_grounded = false

const current_score_key = "current_score"
const best_score_key = "best_score"
const last_best_score_key = "last_best_score"
const medal_key = "medal"

const MEDAL_BRONZE_SCORE = 10
const MEDAL_SILVER_SCORE = 20
const MEDAL_GOLD_SCORE = 30
const MEDAL_PLATINUM_SCORE = 40

func _ready():
	pass
	
func _on_pipe_score_checkpoint_crossed():
	increment_score()

func increment_score():
	current_score += 1
	audio_player.get_node("sfx_point").play()
	$hud.update_live_score(current_score)

func _on_bird_grounded():
	if is_grounded: 
		return
	else:
		is_grounded = true

	# save current score
	data_store.put(current_score_key, current_score)

	# save last best score
	var last_best_score = 0
	if data_store.has(best_score_key):
		last_best_score = data_store.get(best_score_key)
	data_store.put(last_best_score_key, last_best_score)

	# save best score
	data_store.put(best_score_key, last_best_score)
	if last_best_score < current_score:
		data_store.put(best_score_key, current_score)

	_allote_medal(data_store.get(best_score_key))
	$hud.show_gameover_panel()

func _allote_medal(score):
	var medal
	if score >= MEDAL_PLATINUM_SCORE:
		medal = "platinum"
	elif score >= MEDAL_GOLD_SCORE:
		medal = "gold"
	elif score >= MEDAL_SILVER_SCORE:
		medal = "silver"
	elif score >= MEDAL_BRONZE_SCORE:
		medal = "bronze"
	else:
		medal = ""
	
	data_store.put(medal_key, medal)
